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

variable "cloudarmor_policy_name" {
    type = string
    default = "backened-service-policy-seotest"
}

variable "deinal_ip_range_list" {
    type = list(string)
    default = ["*"]
}

variable "allow_ip_range_list" {
    type = list(string)
    default = ["1.1.16.0/24","1.5.6.0/24","2.9.0.0/17","20.2.12.0/18","2.14.0.0/16","5.9.8.1","5.3.5.82","5.0.9.86","5.0.1.228"]
}
