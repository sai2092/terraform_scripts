#  health check
variable "health_check_name" {
  type    = string
  default = "kibana-health-check"
}

variable "health_check_description" {
  type    = string
  default = "Health check via TCP"
}


# backend service
variable "backend_service_name" {
  type    = string
  default = "kibana-backend-service"
}

variable "ssl_certificate_ids" {
  type    = list(string)
  default = []
}

variable "security_policy" {
  type    = string
  default = null
}

variable "instance_group" {
  type    = string
  default = null
}

variable "elkglb_external_ip_address" {
  type    = string
  default = "3.9.1.7"
}

variable "project" {
  type    = string
  default = "digital-seo-dev"
}

variable "labels" {
  type = map(string)
  default = {
    "itpr"        = "itpr69"
    "costcenter"  = "10"
    "owner"       = "seoteam"
    "application" = "glb"
  }
}
