variable "project_id" {
  type    = string
  default = "digital-dev"
}

variable "region" {
  type    = string
  default = "us-central1"
}

variable "zone" {
  type    = string
  default = "us-central1-b"
}

variable "vpc_connector_name" {
  type    = string
  default = "vpc-connector"
}

variable "vpc_connector_cidr_range" {
  type    = string
  default = "1.0.0.0/28"
}

variable "vpc_connector_network" {
  type    = string
  default = "prod-vpc"
}

variable "vpc_connector_subnetwork" {
  type    = string
  default = "1.0.0.0/28"
}