resource "google_storage_bucket" "bucket" {
  name                        = var.bucket_name
  location                    = var.bucket_location
  force_destroy               = true
  storage_class               = var.bucket_storage_class
  uniform_bucket_level_access = var.uniform_bucket_access
  requester_pays              = var.requester_pays_enabled
  labels                      = var.bucket_labels

  dynamic "encryption" {
    for_each = var.bucket_encryption_key
    content {
      kms_key_name = encryption.value
    }
  }

  dynamic "lifecycle_rule" {
    for_each = var.lifecycle_delete_age_rules
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
    for_each = var.lifecycle_storageclass_age_rules
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