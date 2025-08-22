project_id      = "digital-seo-prod"
region          = "us-central1"
zone            = "us-central1-b"
#ssl_certificate
ssl_certificate_name = "ssl-certificate-for-seo-prodglbc"
#GCLB
health_check_name = "test-health-check"
instance_group_zone = "us-central1-b"
instance_group_name = "kibanagroup"
backend_service_name = "kibana-backend-service"
elkglb_external_ip_address = "31.1.1.0"
elkglb_labels = {
  "itpr"        = "i69"
  "costcenter"  = "910"
  "owner"       = "team"
  "application" = "kibanaglb"
}
