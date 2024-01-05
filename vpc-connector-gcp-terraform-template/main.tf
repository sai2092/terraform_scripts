terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "3.74.0"
    }
    google-beta = {
      source  = "hashicorp/google-beta"
      version = "3.74.0"
    }
  }
}

provider "google" {
  # credentials = file("../credentials.json")
  project     = var.project_id
  region      = var.region
  zone        = var.zone
}

provider "google-beta" {
  # credentials = file("../credentials.json")
  project     = var.project_id
  region      = var.region
  zone        = var.zone
}

terraform {
  backend "gcs" {
    bucket = "<GCP BUCKET NAME>" #example:terraform
    prefix = "<PATH FOR GCP RESOURCE STATEFILE>" #example:terraform/digital-pt/cloudsql/instance1/
  }
}

resource "google_vpc_access_connector" "connector" {
  provider = google-beta
  name     = var.vpc_connector_name
  subnet {
    name = var.vpc_connector_subnetwork
  }
  # ip_cidr_range = var.vpc_connector_cidr_range
  # network       = var.vpc_connector_network
}
