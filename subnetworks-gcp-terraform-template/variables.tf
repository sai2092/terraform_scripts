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

variable "subnet_network" {
  type    = string
  default = "sfo-vpc"
}

variable "subnets" {
  type = list(map(string))
  default = [
    {
      subnet_name     = "subnet-01"
      subnet_ip_range = "10.20.30.0/24"
      subnet_region   = "us-west1"
    }
  ]
}
