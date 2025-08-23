terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "3.74.0"
    }
  }
}

provider "google" {
  # credentials = file("../credentials.json")
  project = var.project_id
  region  = var.region
  zone    = var.zone
}

terraform {
  backend "gcs" {
    bucket = "<GCP BUCKET NAME>" #example:terraform
    prefix = "<PATH FOR GCP RESOURCE STATEFILE>" #example:terraform/digital-pbm-rx-pt/cloudsql/instance1/
  }
}

resource "google_cloud_run_service" "default" {
  for_each = { for index, value in var.container_details : index => value }
  name     = each.value.container_name
  location = each.value.conatainer_location

  template {
    spec {
      container_concurrency = each.value.container_concurrency
      timeout_seconds       = each.value.request_timeout
      containers {
        image   = each.value.container_image
        args    = each.value.container_args
        command = each.value.command_list
        ports {
          container_port = each.value.container_port
          name           = each.value.container_port_name
        }
        dynamic "env" {
          for_each = each.value.environment_variables
          content {
            name  = env.value["name"]
            value = env.value["value"]
          }
        }
        resources {
          limits = {
            "cpu" : "${each.value.container_cpu * 1000}m",
            "memory" : each.value.container_memory
          }
        }
      }
    }
    metadata {
      annotations = merge(
        each.value.vpc_access == null ? {} : {
          "run.googleapis.com/vpc-access-connector" = each.value.vpc_access["connector"]
          "run.googleapis.com/vpc-access-egress"    = each.value.vpc_access["egress"]
        }
      )
    }
  }

  metadata {
    labels = each.value.container_labels
    annotations = {
      "run.googleapis.com/ingress" = each.value.ingress
    }
  }
  traffic {
    percent         = 100
    latest_revision = true
  }
}

resource "google_cloud_run_service_iam_member" "public_access" {
  depends_on = [google_cloud_run_service.default]
  for_each   = { for index, value in var.container_details : index => value if value.allow_public_access }
  service    = each.value.container_name
  location   = each.value.conatainer_location
  role       = "roles/run.invoker"
  member     = "allUsers"
}
