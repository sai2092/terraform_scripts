terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "3.74.0"
    }
  }
}

terraform {
  backend "gcs" {
    bucket = "<GCP BUCKET NAME>" #example:terraform
    prefix = "<PATH FOR GCP RESOURCE STATEFILE>" #example:terraform/digital-pbm-rx-pt/cloudsql/instance1/
  }
}

provider "google" {
  # credentials = file("../credentials.json")

  project = var.project_id
  region  = var.region
  zone    = var.zone
}

resource "google_compute_security_policy" "backend-security-policy" {
  name = var.cloudarmor_policy_name
  rule {
    action   = "deny(403)"
    priority = "2147483647"
    match {
      versioned_expr = "SRC_IPS_V1"
      config {
        src_ip_ranges = var.deinal_ip_range_list
      }
    }
    description = "Deny access to IPs"
  }

  rule {
    action   = "allow"
    priority = "1000"
    match {
      versioned_expr = "SRC_IPS_V1"
      config {
        src_ip_ranges = var.allow_ip_range_list
      }
    }
    description = "Allow acces to Ips"
  }
}
