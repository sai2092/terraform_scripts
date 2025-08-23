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

variable "container_details" {
  type = list(object({
    container_image       = string,
    container_name        = string,
    conatainer_location   = string,
    container_labels      = map(string),
    command_list          = list(string),
    container_args        = list(string),
    container_port        = number,
    container_port_name   = string,
    container_cpu         = number,
    container_memory      = string,
    environment_variables = list(map(string)),
    vpc_access            = map(string),
    ingress               = string,
    allow_public_access   = bool,
    container_concurrency = number,
    request_timeout       = number
  }))
}
