variable "project_id" {
  type    = string
  default = "digital-seo-dev"
}

variable "instance_region" {
  type    = string
  default = "us-central1"
}

variable "instance_zone" {
  type    = string
  default = "us-central1-b"
}

# elasitc search
variable "reserved_elastic_ip_address" {
  type    = list(string)
  default = ["10.128.0.28", "10.128.0.29", "10.128.0.30"]
}

variable "elastic_labels" {
  type = map(string)
  default = {
    "itpr"        = "itpr09"
    "costcenter"  = "9"
    "owner"       = "seoteam"
    "application" = "elastic"
  }
}

variable "elastic_instance_name_prefix" {
  type    = string
  default = "seo-dev-elastic-instance"
}

variable "elastic_instance_machine_type" {
  type    = string
  default = "e2-standard-2"
}

variable "elastic_instance_image_type" {
  type    = string
  default = "debian-cloud/debian-9"
}

variable "elastic_instance_disk_type" {
  type    = string
  default = "pd-standard"
}

variable "elastic_instance_network" {
  type    = string
  default = "seo-vpc"
}

variable "elastic_instance_subnetwork" {
  type    = string
  default = "seo-prod-vpc"
}

variable "elastic_instance_disk_size" {
  type    = number
  default = 50
}

variable "elastic_version" {
  type    = string
  default = "7.10.0"
}

variable "elastic_network_source_range" {
  type    = list(string)
  default = ["0.0.0.0/0"]
}

variable "elastic_ports_list" {
  type    = list(number)
  default = [9200, 9300]
}

variable "elastic_user_password" {
  type    = string
  default = "C#epp@nu#BroTheR"
}

variable "elastic_network_tags" {
  type    = list(string)
  default = ["elastic"]
}

variable "elastic_instance_data_disk_type" {
  type    = string
  default = "pd-standard"
}

variable "elastic_instance_data_disk_size" {
  type    = number
  default = 50
}

# logstash
variable "reserved_logstash_ip_address" {
  type    = list(string)
  default = ["1.0.0.5"]
}

variable "logstash_instance_name_prefix" {
  type    = string
  default = "seo-dev-logstash-instance"
}

variable "logstash_instance_machine_type" {
  type    = string
  default = "e2-standard-2"
}

variable "logstash_instance_image_type" {
  type    = string
  default = "debian-cloud/debian-9"
}

variable "logstash_labels" {
  type = map(string)
  default = {
    "itpr"        = "itpr09"
    "costcenter"  = "9"
    "owner"       = "seoteam"
    "application" = "logstash"
  }
}

variable "logstash_instance_disk_type" {
  type    = string
  default = "pd-standard"
}

variable "logstash_instance_network" {
  type    = string
  default = "test-vpc"
}

variable "logstash_instance_subnetwork" {
  type    = string
  default = "seo-prod-vpc"
}

variable "logstash_instance_disk_size" {
  type    = number
  default = 50
}

variable "logstash_version" {
  type    = string
  default = "1:7.10.0-1"
}

variable "logstash_network_source_range" {
  type    = list(string)
  default = ["0.0.0.0/0"]
}

variable "logstash_ports_list" {
  type    = list(number)
  default = [9600]
}

variable "logstash_network_tags" {
  type    = list(string)
  default = ["logstash"]
}

variable "logstash_instance_data_disk_type" {
  type    = string
  default = "pd-standard"
}

variable "logstash_instance_data_disk_size" {
  type    = number
  default = 50
}

# kibana
variable "reserved_kibana_ip_address" {
  type    = list(string)
  default = ["1.0.0.6"]
}

variable "kibana_instance_name_prefix" {
  type    = string
  default = "kibana-instance"
}

variable "kibana_instance_machine_type" {
  type    = string
  default = "e2-standard-2"
}

variable "kibana_labels" {
  type = map(string)
  default = {
    "itpr"        = "itpr09"
    "costcenter"  = "9"
    "owner"       = "seoteam"
    "application" = "kibana"
  }
}

variable "kibana_instance_image_type" {
  type    = string
  default = "debian-cloud/debian-9"
}

variable "kibana_instance_disk_type" {
  type    = string
  default = "pd-standard"
}

variable "kibana_instance_network" {
  type    = string
  default = "test-vpc"
}

variable "kibana_instance_subnetwork" {
  type    = string
  default = "seo-prod-vpc"
}

variable "kibana_instance_disk_size" {
  type    = number
  default = 50
}

variable "kibana_version" {
  type    = string
  default = "7.10.0"
}

variable "kibana_network_source_range" {
  type    = list(string)
  default = ["0.0.0.0/0"]
}

variable "health_check_network_source_range" {
  type    = list(string)
  default = ["0.0.0.0/0"]
}

variable "kibana_ports_list" {
  type    = list(number)
  default = [5601]
}

variable "kibana_network_tags" {
  type    = list(string)
  default = ["kibana"]
}

# ssl certs
variable "gcs_folder" {
  type    = string
  default = "gs://gcs-elk-bucket/ssl_certs"
}

# cloud armor

variable "cloudarmor_policy_name" {
  type    = string
  default = "elk-backened-service-policy"
}

variable "kibana_service_deinal_ip_list" {
  type    = list(string)
  default = ["*"]
}

variable "kibana_service_allow_ip_list" {
  type    = list(string)
  default = ["1.5.1.0/24", "1.1.1.0/24", "2.9.0.0/17", "6.2.2.0/18"]
}

#GLB For ELK
variable "elkglb_external_ip_address" {
  type    = string
  default = "3.1.5.7"
}

variable "elkglb_labels" {
  type = map(string)
  default = {
    "itpr"        = "itpr09"
    "costcenter"  = "9"
    "owner"       = "seoteam"
    "application" = "kibanaglb"
  }
}

variable "health_check_name" {
  type    = string
  default = "kibana-health-check"
}

variable "backend_service_name" {
  type    = string
  default = "kibana-backend-service"
}

variable "ssl_certificate_name" {
  type    = string
  default = "ssl-certificate-for-elkglb"
}

# cloud storage for ELK
variable "bucket_name" {
  type    = string
  default = "gcs-elk-bucket"
}

variable "bucket_location" {
  type    = string
  default = "US"
}

variable "uniform_bucket_access" {
  type    = bool
  default = true
}

variable "requester_pays_enabled" {
  type    = bool
  default = false
}

variable "bucket_labels" {
  type = map(string)
  default = {
    "itpr"        = "itpr09"
    "costcenter"  = "9"
    "owner"       = "seoteam"
    "application" = "storage"
  }
}

variable "lifecycle_delete_age_rules" {
  type    = list(number)
  default = []
}

variable "lifecycle_storageclass_age_rules" {
  type = list(map(string))
  default = [
    #   {
    #   "storageClass" = "NEARLINE"
    #   "age"          = "10"
    # }
  ]
}

variable "bucket_storage_class" {
  type    = string
  default = "Standard"
}

variable "bucket_encryption_key" {
  type    = list(string)
  default = []
}

#Nat
variable "router_name" {
  type = string
}

variable "nat_name" {
  type = string
}

variable "nat_router_network_name" {
  type = string
}

variable "router_asn" {
  type    = number
  default = 64514
}

variable "nat_router_region" {
  type    = string
  default = "us-central1"
}

variable "nat_ip_allocate_option" {
  type    = bool
  default = false
}

variable "nat_ips" {
  type    = list(string)
  default = []
}

variable "nat_subnetworks" {
  type = list(object({
    name                     = string,
    source_ip_ranges_to_nat  = list(string)
    secondary_ip_range_names = list(string)
  }))
  default = []
}

variable "enable_endpoint_independent_mapping" {
  type        = bool
  description = "Specifies if endpoint independent mapping is enabled."
  default     = false
}
