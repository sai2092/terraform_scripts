project_id = "digital-prod"
region     = "us-central1"
zone       = "us-central1-b"
#subnets
subnet_network = "prod-vpc"
subnets = [
  {
    subnet_name     = "prod-vpc"
    subnet_ip_range = "20.18.0.0/20"
    subnet_region   = "us-central1"
  },
  {
    subnet_name     = "sfo-vpc-serverlessconn"
    subnet_ip_range = "20.8.0.0/28"
    subnet_region   = "us-central1"
  }
]
