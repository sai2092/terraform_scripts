variable "project_id" {
  type    = string
  default = "digital-prod"
}

variable "region" {
  type    = string
  default = "us-central1"
}

variable "zone" {
  type    = string
  default = "us-central1-b"
}

variable "bigquery_dataset_list" {
  type = list(object({
    dataset_id                  = string
    location                    = string
    friendly_name               = string
    default_table_expiration_ms = number
    labels                      = map(string)
    description                 = string
    bigquery_encryption_key     = list(string)
    access                      = any
  }))
}
