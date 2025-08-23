variable "reserved_ip_address" {
  type    = list(string)
  default = ["1.8.0.2", "1.1.0.2", "1.1.0.3"]
}

variable "labels" {
  type = map(string)
  default = {
    "itpr"        = "itpr07"
    "costcenter"  = "90"
    "owner"       = "seoteam"
    "application" = "elasticsearch"
  }
}

variable "name_prefix" {
  type    = string
  default = "seo-dev-elastic-instance"
}

variable "machine_type" {
  type    = string
  default = "e2-standard-2"
}

variable "image_type" {
  type    = string
  default = "debian-cloud/debian-9"
}

variable "disk_type" {
  type    = string
  default = "pd-standard"
}

variable "disk_size" {
  type    = number
  default = 50
}

variable "network" {
  type    = string
  default = "seo-vpc"
}

variable "subnetwork" {
  type    = string
  default = "seo-vpc"
}

variable "data_disk_type" {
  type    = string
  default = "pd-standard"
}

variable "data_disk_size" {
  type    = number
  default = 50
}

variable "elastic_version" {
  type    = string
  default = "7.10.0"
}

variable "elastic_network_source_range" {
  type    = list(string)
  default = ["1.1.0.0/20"]
}

variable "ports_list" {
  type    = list(number)
  default = [9200, 9300]
}

variable "elastic_user_password" {
  type    = string
  default = "C#epp@nu#BroTheR"
}

variable "network_tags" {
  type    = list(string)
  default = ["elastic", "allow-iap"]
}

# ssl certs
variable "gcs_folder" {
  type    = string
  default = "gs://gcs-elk-bucket/ssl_certs"
}
