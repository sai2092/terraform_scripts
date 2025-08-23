project_id      = "digital-seo-prod"
instance_region = "us-central1"
instance_zone   = "us-central1-b"
# elasitc search
reserved_elastic_ip_address     = ["10.1.0.1", "10.1.0.2", "10.8.0.3"]
elastic_instance_name_prefix    = "seo-prod-elastic"
elastic_instance_machine_type   = "e2-standard-8"
elastic_instance_image_type     = "debian-cloud/debian-9"
elastic_instance_disk_type      = "pd-standard"
elastic_instance_disk_size      = 512
elastic_instance_data_disk_type = "pd-standard"
elastic_instance_data_disk_size = 1000
elastic_instance_network        = "seo-prod-vpc"
elastic_instance_subnetwork     = "seo-prod-vpc"
elastic_network_source_range    = ["10.8.0.0/20"]
elastic_ports_list              = [9200, 9300]
elastic_version                 = "7.10.0"
elastic_network_tags            = ["elastic", "allow-iap"]
elastic_labels = {
  "itpr"        = "itpr09"
  "costcenter"  = "90"
  "owner"       = "seo"
  "application" = "elasticsearch"
}
# logstash
reserved_logstash_ip_address     = ["10.8.0.3"]
logstash_instance_name_prefix    = "seo-prod-logstash"
logstash_instance_machine_type   = "e2-standard-8"
logstash_instance_image_type     = "debian-cloud/debian-9"
logstash_instance_disk_type      = "pd-standard"
logstash_instance_disk_size      = 512
logstash_instance_data_disk_type = "pd-standard"
logstash_instance_data_disk_size = 512
logstash_instance_network        = "seo-prod-vpc"
logstash_instance_subnetwork     = "seo-prod-vpc"
logstash_network_source_range    = ["10.8.0.0/20"]
logstash_ports_list              = [9600]
logstash_version                 = "1:7.10.0-1"
logstash_network_tags            = ["logstash", "allow-iap"]
logstash_labels = {
  "itpr"        = "itpr09"
  "costcenter"  = "90"
  "owner"       = "seo"
  "application" = "logstash"
}
# kibana
reserved_kibana_ip_address        = ["10.8.0.35"]
kibana_instance_name_prefix       = "seo-prod-kibana"
kibana_instance_machine_type      = "e2-standard-8"
kibana_instance_image_type        = "debian-cloud/debian-9"
kibana_instance_disk_type         = "pd-standard"
kibana_instance_disk_size         = 512
kibana_instance_network           = "seo-prod-vpc"
kibana_instance_subnetwork        = "seo-prod-vpc"
kibana_network_source_range       = ["10.8.0.0/20"]
health_check_network_source_range = ["5.1.0.0/16", "1.2.0.0/22"]
kibana_ports_list                 = [5601]
kibana_version                    = "7.10.0"
kibana_network_tags               = ["kibana", "allow-iap", "allowhealthcheck"]
kibana_labels = {
  "itpr"        = "itpr09"
  "costcenter"  = "90"
  "owner"       = "seo"
  "application" = "kibana"
}
#GCS
bucket_name                      = "gcs-prod-elk-bucket"
bucket_location                  = "US"
uniform_bucket_access            = true
requester_pays_enabled           = false
bucket_storage_class             = "Standard"
bucket_encryption_key            = []
lifecycle_storageclass_age_rules = []
lifecycle_delete_age_rules       = []
gcs_folder                       = "gs://gcs-prod-elk-bucket/ssl_certs"
#elastic_user_password            = ""
bucket_labels = {
  "itpr"        = "itpr09"
  "costcenter"  = "90"
  "owner"       = "seo"
  "application" = "elkbucket"
}
#Nat
router_name                         = "elk-router"
nat_router_network_name             = "seo-vpc"
router_asn                          = 64514
nat_router_region                   = "us-central1"
nat_name                            = "elk-nat"
nat_ip_allocate_option              = false
nat_ips                             = []
nat_subnetworks                     = []
enable_endpoint_independent_mapping = false
# cloud armor
cloudarmor_policy_name        = "elk-backened-service-policy"
kibana_service_deinal_ip_list = ["*"]
kibana_service_allow_ip_list  = ["1.5.1.0/24", "1.1.1.0/24", "2.9.0.0/17", "6.2.2.0/18"]
#GLB For Kibana
health_check_name          = "kibana-health-check"
backend_service_name       = "kibana-backend-service"
ssl_certificate_name       = "ssl-certificate-for-elkglb"
elkglb_external_ip_address = "3.0.8.1"
elkglb_labels = {
  "itpr"        = "itpr09"
  "costcenter"  = "90"
  "owner"       = "seo"
  "application" = "kibanaglb"
}
