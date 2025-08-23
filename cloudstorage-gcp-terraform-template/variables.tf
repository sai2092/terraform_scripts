variable "project_id" {
  type    = string
  default = "digital-seo-prod"
}

variable "region" {
  type    = string
  default = "us-central1"
}

variable "zone" {
  type    = string
  default = "us-central1-b"
}

variable "bucket_list" {
  type = list(object({
    bucket_name                      = string,
    bucket_location                  = string,
    bucket_storage_class             = string,
    uniform_bucket_access            = bool,
    requester_pays_enabled           = bool,
    bucket_labels                    = map(string),
    bucket_encryption_key            = list(string),
    lifecycle_delete_age_rules       = list(number),
    lifecycle_storageclass_age_rules = list(map(string)),
    access                           = list(any)
  }))
}
