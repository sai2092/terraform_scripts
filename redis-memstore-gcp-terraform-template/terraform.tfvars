project_id                  = "digital-microservices-prod"
region                      = "us-west2"
enable_apis                 = "false"
activate_apis               = []
activate_api_identities     = []
disable_services_on_destroy = true
disable_dependent_services  = true
network_details             = [{ "redis_network" = "vpc-hub-prod-1", "redis_network_project" = "vpc-equinix" }]
instance_details = [
  {
    name                    = "client-api-prod-dr"
    authorized_network      = "vpc-hub-prod-1"
    tier                    = "STANDARD_HA"
    memory_size_gb          = 10
    location_id             = "us-west2-a"
    alternative_location_id = "us-west2-b"
    redis_configs = {
      "timeout" = 120
    }
    redis_version           = "REDIS_6_X"
    display_name            = "Client API PROD Instance"
    reserved_ip_range       = "google-private-services-usw2-prod-1"
    connect_mode            = "PRIVATE_SERVICE_ACCESS"
    labels                  = { "env" = "proddr", "app" = "clientapi", "itpr" = "itpr274", "costcenter" = "642" },
    auth_enabled            = true,
    transit_encryption_mode = "SERVER_AUTHENTICATION"
  }
]
