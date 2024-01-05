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

variable "firewall_rule_network" {
    type = string
    default = "prod-vpc"
}

variable "rules" {
  type = list(object({
    name                    = string
    direction               = string
    priority                = number
    ranges                  = list(string)
    source_tags             = list(string)
    target_tags             = list(string)
    allow = list(object({
      protocol = string
      ports    = list(string)
    }))
    deny = list(object({
      protocol = string
      ports    = list(string)
    }))
  }))
  default = [{
    name                    = "allow-ssh"
    direction               = "INGRESS"
    priority                = null
    ranges                  = ["0.0.0.0/0"]
    source_tags             = null
    target_tags             = null
    allow = [{
      protocol = "tcp"
      ports    = ["22"]
    }]
    deny = []
  }]
}
