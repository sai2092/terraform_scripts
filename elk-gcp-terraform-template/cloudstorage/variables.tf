variable "bucket_name" {
  type    = string
  default = "gcs-elk-bucket"
}

variable "bucket_location" {
  type    = string
  default = "US"
}

variable "uniform_bucket_access" {
  type    = bool
  default = true
}

variable "requester_pays_enabled" {
  type    = bool
  default = false
}

variable "bucket_labels" {
  type = map(string)
  default = {
  "itpr"        = "itpr69"
  "costcenter"  = "90"
  "owner"       = "steam"
  "application" = "elkbucket"
  }
}

variable "lifecycle_delete_age_rules" {
  type    = list(number)
  default = []
}

variable "lifecycle_storageclass_age_rules" {
  type = list(map(string))
  default = [
  #   {
  #   "storageClass" = "NEARLINE"
  #   "age"          = "10"
  # }
]
}

variable "bucket_storage_class" {
  type    = string
  default = "Standard"
}

variable "bucket_encryption_key" {
  type    = list(string)
  default = []
}
