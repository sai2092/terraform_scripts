project_id      = "digital-seo-prod"
region          = "us-central1"
zone            = "us-central1-b"
#Nat
router_name = "seo-prod-cr-central"
nat_router_network_name = "seo-prod-vpc"
router_asn = 64514
nat_router_region = "us-central1"
nat_name = "seo-prod-nat-central"
nat_ip_allocate_option = false
nat_ips = []
nat_subnetworks = []
enable_endpoint_independent_mapping = false
