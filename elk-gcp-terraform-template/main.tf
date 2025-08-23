terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "3.74.0"
    }
  }
}

provider "google" {
  # credentials = file("credentials.json")
  project = var.project_id
  region  = var.instance_region
  zone    = var.instance_zone
}

terraform {
  backend "gcs" {
    bucket = "<GCP BUCKET NAME>" #example:terraform
    prefix = "<PATH FOR GCP RESOURCE STATEFILE>" #example:terraform/digital-pbm-rx-pt/cloudsql/instance1/
  }
}

module "cloudstorage" {
  source                           = "./cloudstorage"
  bucket_name                      = var.bucket_name
  bucket_location                  = var.bucket_location
  bucket_labels                    = var.bucket_labels
  bucket_storage_class             = var.bucket_storage_class
  lifecycle_delete_age_rules       = var.lifecycle_delete_age_rules
  lifecycle_storageclass_age_rules = var.lifecycle_storageclass_age_rules
  uniform_bucket_access            = var.uniform_bucket_access
  bucket_encryption_key            = var.bucket_encryption_key
}

# module "cloud-nat" {
#   source     = "./cloud_nat"
#   router_name = var.router_name
#   nat_name = var.nat_name
#   network = var.nat_router_network_name
#   router_asn = var.router_asn
#   nat_ip_allocate_option = var.nat_ip_allocate_option
#   nat_ips = var.nat_ips
#   subnetworks = var.nat_subnetworks
#   nat_router_region = var.nat_router_region
#   enable_endpoint_independent_mapping = var.enable_endpoint_independent_mapping
# }

module "ssl_certificate" {
  source               = "./ssl_certificate"
  ssl_certificate_name = var.ssl_certificate_name
}

module "elasticsearch" {
  source                       = "./elasticsearch"
  reserved_ip_address          = var.reserved_elastic_ip_address
  name_prefix                  = var.elastic_instance_name_prefix
  machine_type                 = var.elastic_instance_machine_type
  image_type                   = var.elastic_instance_image_type
  disk_type                    = var.elastic_instance_disk_type
  disk_size                    = var.elastic_instance_disk_size
  data_disk_type               = var.elastic_instance_data_disk_type
  data_disk_size               = var.elastic_instance_data_disk_size
  network                      = var.elastic_instance_network
  subnetwork                   = var.elastic_instance_subnetwork
  elastic_network_source_range = var.elastic_network_source_range
  ports_list                   = var.elastic_ports_list
  elastic_version              = var.elastic_version
  labels                       = var.elastic_labels
  network_tags                 = var.elastic_network_tags
  elastic_user_password        = var.elastic_user_password
  depends_on                   = [module.cloudstorage]
  gcs_folder                   = var.gcs_folder
}

module "logstash" {
  source                        = "./logstash"
  reserved_ip_address           = var.reserved_logstash_ip_address
  name_prefix                   = var.logstash_instance_name_prefix
  machine_type                  = var.logstash_instance_machine_type
  image_type                    = var.logstash_instance_image_type
  disk_type                     = var.logstash_instance_disk_type
  disk_size                     = var.logstash_instance_disk_size
  data_disk_type                = var.logstash_instance_data_disk_type
  data_disk_size                = var.logstash_instance_data_disk_size
  network                       = var.logstash_instance_network
  subnetwork                    = var.logstash_instance_subnetwork
  labels                        = var.logstash_labels
  network_tags                  = var.logstash_network_tags
  logstash_version              = var.logstash_version
  logstash_network_source_range = var.logstash_network_source_range
  ports_list                    = var.logstash_ports_list
  elastic_user_password         = var.elastic_user_password
  elastic_cluster_master        = module.elasticsearch.master_name
  depends_on                    = [module.cloudstorage]
  gcs_folder                    = var.gcs_folder
}

module "kibana" {
  source                            = "./kibana"
  reserved_ip_address               = var.reserved_kibana_ip_address
  name_prefix                       = var.kibana_instance_name_prefix
  machine_type                      = var.kibana_instance_machine_type
  image_type                        = var.kibana_instance_image_type
  disk_type                         = var.kibana_instance_disk_type
  disk_size                         = var.kibana_instance_disk_size
  network                           = var.kibana_instance_network
  subnetwork                        = var.kibana_instance_subnetwork
  labels                            = var.kibana_labels
  network_tags                      = var.kibana_network_tags
  kibana_version                    = var.kibana_version
  ports_list                        = var.kibana_ports_list
  elastic_user_password             = var.elastic_user_password
  kibana_network_source_range       = var.kibana_network_source_range
  elastic_cluster_master            = module.elasticsearch.master_name
  health_check_network_source_range = var.health_check_network_source_range
  depends_on                        = [module.cloudstorage]
  gcs_folder                        = var.gcs_folder
}

module "cloudarmor" {
  source                 = "./cloudarmor"
  cloudarmor_policy_name = var.cloudarmor_policy_name
  allow_ip_range_list    = var.kibana_service_allow_ip_list
  deinal_ip_range_list   = var.kibana_service_deinal_ip_list
}

module "global_load_balancer" {
  source                     = "./global_load_balancer"
  health_check_name          = var.health_check_name
  backend_service_name       = var.backend_service_name
  elkglb_external_ip_address = var.elkglb_external_ip_address
  security_policy            = module.cloudarmor.security_policy_self_link
  instance_group             = module.kibana.instance_group_id
  ssl_certificate_ids        = [module.ssl_certificate.ssl_certificate_id]
  project                    = var.project_id
  labels                     = var.elkglb_labels
}
