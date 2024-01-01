terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "3.74.0"
    }
  }
}

provider "google" {
  # credentials = file("../credentials.json") #To Deploy Resources with credentials file
  project = var.project_id
  region  = var.region
  zone    = var.zone
}

terraform {
  backend "gcs" {
    bucket = "<GCP BUCKET NAME>" #example:terraform
    prefix = "<PATH FOR GCP RESOURCE STATEFILE>" #example:terraform/digital-pbm/cloudsql/instance1/
  }
}

locals {
  iam_to_primitive = {
    "roles/bigquery.dataOwner" : "OWNER"
    "roles/bigquery.dataEditor" : "WRITER"
    "roles/bigquery.dataViewer" : "READER"
  }
}

resource "google_bigquery_dataset" "default" {
  for_each                    = { for index, value in var.bigquery_dataset_list : index => value }
  dataset_id                  = each.value.dataset_id
  friendly_name               = each.value.friendly_name
  description                 = each.value.description
  location                    = each.value.location
  default_table_expiration_ms = each.value.default_table_expiration_ms
  labels                      = each.value.labels
  dynamic "default_encryption_configuration" {
    for_each = each.value.bigquery_encryption_key == null ? [] : each.value.bigquery_encryption_key
    content {
      kms_key_name = default_encryption_configuration.value
    }
  }
  dynamic "access" {
    for_each = each.value.access == null ? [] : each.value.access
    content {
      role = lookup(local.iam_to_primitive, access.value.role, access.value.role)

      domain         = lookup(access.value, "domain", null)
      group_by_email = lookup(access.value, "group_by_email", null)
      user_by_email  = lookup(access.value, "user_by_email", null)
      special_group  = lookup(access.value, "special_group", null)
    }
  }

}
