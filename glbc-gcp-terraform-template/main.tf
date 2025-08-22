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

module "ssl_certificate" {
  source = "./ssl_certificate"
  ssl_certificate_name = var.ssl_certificate_name
}

module "global_load_balancer" {
  source                     = "./global_load_balancer"
  health_check_name          = var.health_check_name
  backend_service_name       = var.backend_service_name
  elkglb_external_ip_address = var.elkglb_external_ip_address
  security_policy_name       = var.security_policy_name
  instance_group_name        = var.instance_group_name
  instance_group_zone        = var.instance_group_zone
  ssl_certificate_ids        = [module.ssl_certificate.ssl_certificate_id]
  project                    = var.project_id
  labels                     = var.elkglb_labels
}
