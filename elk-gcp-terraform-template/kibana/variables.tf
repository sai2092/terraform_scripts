variable "reserved_ip_address" {
  type    = list(string)
  default = ["1.1.0.7"]
}

variable "name_prefix" {
  type    = string
  default = "seo-dev-kibana-instance"
}

variable "machine_type" {
  type    = string
  default = "e2-standard-2"
}

variable "labels" {
  type = map(string)
  default = {
    "itpr"        = "itpr9"
    "costcenter"  = "10"
    "owner"       = "seoteam"
    "application" = "kibana"
  }
}

variable "image_type" {
  type    = string
  default = "debian-cloud/debian-9"
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

variable "kibana_version" {
  type    = string
  default = "7.10.0"
}

variable "kibana_network_source_range" {
  type    = list(string)
  default = ["1.8.0.0/20"]
}

variable "ports_list" {
  type    = list(number)
  default = [5601]
}

variable "network_tags" {
  type    = list(string)
  default = ["kibana", "allow-iap", "allowhealthcheck"]
}

variable "elastic_cluster_master" {
  type = string
}

variable "elastic_user_password" {
  type    = string
  default = "C#epp@nu#BroTheR"
}

# ssl certs
variable "gcs_folder" {
  type    = string
  default = "gs://gcs-elk-bucket/ssl_certs"
}

variable "health_check_network_source_range" {
  type    = list(string)
  default = ["3.1.0.0/16", "1.2.0.0/22"]
}
