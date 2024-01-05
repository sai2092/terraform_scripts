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

variable "vpc_network_name" {
  type        = string
  default = "sample-network"
}

variable "vpc_routing_mode" {
  type        = string
  default     = "GLOBAL"
}

variable "vpc_auto_create_subnetworks" {
  type        = bool
  default     = false
}

variable "vpc_delete_default_internet_gateway_routes" {
  type        = bool
  default     = false
}

variable "vpc_mtu" {
  type        = number
  default     = 0
}
