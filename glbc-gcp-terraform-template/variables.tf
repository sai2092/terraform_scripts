variable "project_id" {
  type    = string
  default = "digital-seo-dev"
}

variable "region" {
  type    = string
  default = "us-central1"
}

variable "zone" {
  type    = string
  default = "us-central1-b"
}

#LoadBalancer
#health check
variable "health_check_name" {
  type    = string
  default = "health-check"
}

variable "health_check_description" {
  type    = string
  default = "Health check via tcp"
}

# backend service
variable "backend_service_name" {
  type    = string
  default = "backend-service"
}

variable "ssl_certificate_ids" {
  type    = list(string)
  default = []
}

variable "security_policy_name" {
  type    = string
  default = null
}

variable "instance_group_name" {
  type    = string
  default = null
}

variable "instance_group_zone" {
  type    = string
  default = null
}

variable "elkglb_external_ip_address" {
  type    = string
  default = "4.9.5.7"
}

variable "labels" {
  type = map(string)
  default = {
    "itpr"        = "it69"
    "costcenter"  = "90"
    "owner"       = "team"
    "application" = "gclb"
  }
}
#ssl_certificate
variable "ssl_certificate_name" {
  type    = string
  default = "ssl-certificate-for-elkglb"
}
