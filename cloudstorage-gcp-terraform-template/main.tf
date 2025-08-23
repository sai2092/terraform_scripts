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

locals {
  access_list = flatten([
    for index, item in var.bucket_list : [
      for value in item.access : {
        bucket_name = google_storage_bucket.buckets[index].name
        role        = value.role
        members     = value.members
      }
    ]
  ])
}

resource "google_storage_bucket" "buckets" {
  for_each                    = { for index, value in var.bucket_list : index => value }
  name                        = each.value.bucket_name
  location                    = each.value.bucket_location
  force_destroy               = true
  storage_class               = each.value.bucket_storage_class
  uniform_bucket_level_access = each.value.uniform_bucket_access
  requester_pays              = each.value.requester_pays_enabled
  labels                      = each.value.bucket_labels

  dynamic "encryption" {
    for_each = each.value.bucket_encryption_key
    content {
      default_kms_key_name = encryption.value
    }
  }

  dynamic "lifecycle_rule" {
    for_each = each.value.lifecycle_delete_age_rules
    content {
      condition {
        age = lifecycle_rule.value
      }
      action {
        type = "Delete"
      }
    }
  }

  dynamic "lifecycle_rule" {
    for_each = each.value.lifecycle_storageclass_age_rules
    content {
      condition {
        age = lifecycle_rule.value["age"]
      }
      action {
        type          = "SetStorageClass"
        storage_class = lifecycle_rule.value["storageClass"]
      }
    }
  }
}

# resource "google_storage_bucket_iam_binding" "admins" {
#   for_each = { for index, value in local.access_list : index => value }
#   bucket   = each.value.bucket_name
#   role     = each.value.role
#   members  = each.value.members
# }
