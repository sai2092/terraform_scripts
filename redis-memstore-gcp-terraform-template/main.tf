terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "3.83.0"
    }
    google-beta = {
      source  = "hashicorp/google-beta"
      version = "3.83.0"
    }
  }
}

terraform {
  backend "gcs" {
    bucket = "<GCP BUCKET NAME>" #example:terraform
    prefix = "<PATH FOR GCP RESOURCE STATEFILE>" #example:terraform/digital-pbm-rx-pt/cloudsql/instance1/
  }
}

data "google_compute_network" "redis_network" {
  for_each = { for index, value in var.network_details : index => value }
  name     = each.value.redis_network
  project  = each.value.redis_network_project
}

resource "google_redis_instance" "default" {
  depends_on = [google_project_service.project_services]
  for_each   = { for index, value in var.instance_details : index => value }

  project        = var.project_id
  name           = each.value.name
  tier           = each.value.tier
  memory_size_gb = each.value.memory_size_gb


  region                  = var.region
  location_id             = each.value.location_id
  alternative_location_id = each.value.alternative_location_id

  authorized_network = data.google_compute_network.redis_network[0].id
  connect_mode       = each.value.connect_mode


  redis_version     = each.value.redis_version
  redis_configs     = each.value.redis_configs
  display_name      = each.value.display_name
  reserved_ip_range = each.value.reserved_ip_range

  labels = each.value.labels

  auth_enabled = each.value.auth_enabled

  transit_encryption_mode = each.value.transit_encryption_mode
}

locals {
  services = var.enable_apis ? toset(concat(var.activate_apis, [for i in var.activate_api_identities : i.api])) : toset([])
  service_identities = flatten([
    for i in var.activate_api_identities : [
      for r in i.roles :
      { api = i.api, role = r }
    ]
  ])
}

/******************************************
  APIs configuration
 *****************************************/
resource "google_project_service" "project_services" {
  for_each                   = local.services
  project                    = var.project_id
  service                    = each.value
  disable_on_destroy         = var.disable_services_on_destroy
  disable_dependent_services = var.disable_dependent_services
}

resource "google_project_service_identity" "project_service_identities" {
  for_each = {
    for i in var.activate_api_identities :
    i.api => i
  }

  provider = google-beta
  project  = var.project_id
  service  = each.value.api
}

resource "google_project_iam_member" "project_service_identity_roles" {
  for_each = {
    for si in local.service_identities :
    "${si.api} ${si.role}" => si
  }

  project = var.project_id
  role    = each.value.role
  member  = "serviceAccount:${google_project_service_identity.project_service_identities[each.value.api].email}"
}
