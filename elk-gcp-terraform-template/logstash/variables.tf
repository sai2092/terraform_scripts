variable "reserved_ip_address" {
  type    = list(string)
  default = ["10.8.0.6"]
}

variable "name_prefix" {
  type    = string
  default = "seo-dev-logstash-instance"
}

variable "machine_type" {
  type    = string
  default = "e2-standard-2"
}

variable "image_type" {
  type    = string
  default = "debian-cloud/debian-9"
}

variable "labels" {
  type = map(string)
  default = {
    "itpr"        = "itpr09"
    "costcenter"  = "90"
    "owner"       = "seoteam"
    "application" = "logstash"
  }
}

variable "disk_type" {
  type    = string
  default = "pd-standard"
}

variable "network" {
  type    = string
  default = "seo-vpc"
}

variable "subnetwork" {
  type    = string
  default = "seo-vpc"
}

variable "disk_size" {
  type    = number
  default = 50
}

variable "data_disk_type" {
  type    = string
  default = "pd-standard"
}

variable "data_disk_size" {
  type    = number
  default = 50
}

variable "logstash_version" {
  type    = string
  default = "1:7.10.0-1"
}

variable "logstash_network_source_range" {
  type    = list(string)
  default = ["1.8.0.0/20"]
}

variable "ports_list" {
  type    = list(number)
  default = [9600]
}

variable "network_tags" {
  type    = list(string)
  default = ["logstash", "allow-iap"]
}

variable "elastic_user_password" {
  type    = string
  default = "C#epp@nu#BroTheR"
}

variable "elastic_cluster_master" {
  type = string
}

# ssl certs
variable "gcs_folder" {
  type    = string
  default = "gs://gcs-elk-bucket/ssl_certs"
}
