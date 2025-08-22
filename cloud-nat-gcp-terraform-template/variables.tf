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

variable "router_name" {
    type = string
    default = "sample-router"
}

variable "nat_router_network_name" {
  type = string
  default = "seo-vpc"
}

variable "router_asn" {
    type = number
    default = 64514
}

variable "nat_router_region" {
    type = string
    default = "us-central1"
}

variable "nat_name" {
  type = string
  default = "sample-terraform-nat"
}

variable "icmp_idle_timeout_sec" {
  default     = "30"
}

variable "min_ports_per_vm" {
  default     = "64"
}

variable "nat_ip_allocate_option" {
    default     = "false"
}

variable "nat_ips" {
  type        = list(string)
  default     = []
}


variable "source_subnetwork_ip_ranges_to_nat" {
  description = "Valid values include: ALL_SUBNETWORKS_ALL_IP_RANGES, ALL_SUBNETWORKS_ALL_PRIMARY_IP_RANGES, LIST_OF_SUBNETWORKS. Changing this forces a new NAT to be created."
  default     = "ALL_SUBNETWORKS_ALL_IP_RANGES"
}

variable "tcp_established_idle_timeout_sec" {
  description = "Timeout (in seconds) for TCP established connections. Defaults to 1200s if not set. Changing this forces a new NAT to be created."
  default     = "1200"
}

variable "tcp_transitory_idle_timeout_sec" {
  description = "Timeout (in seconds) for TCP transitory connections. Defaults to 30s if not set. Changing this forces a new NAT to be created."
  default     = "30"
}

variable "udp_idle_timeout_sec" {
  description = "Timeout (in seconds) for UDP connections. Defaults to 30s if not set. Changing this forces a new NAT to be created."
  default     = "30"
}

variable "nat_subnetworks" {
  type = list(object({
    name                     = string,
    source_ip_ranges_to_nat  = list(string)
    secondary_ip_range_names = list(string)
  }))
  default = []
}

variable "log_config_enable" {
  type        = bool
  description = "Indicates whether or not to export logs"
  default     = false
}
variable "log_config_filter" {
  type        = string
  description = "Specifies the desired filtering of logs on this NAT. Valid values are: \"ERRORS_ONLY\", \"TRANSLATIONS_ONLY\", \"ALL\""
  default     = "ALL"
}

variable "enable_endpoint_independent_mapping" {
  type        = bool
  description = "Specifies if endpoint independent mapping is enabled."
  default     = false
}
