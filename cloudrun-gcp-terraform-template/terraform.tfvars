project_id = "digital-seo-prod"
region     = "us-central1"
zone       = "us-central1-b"
#CloudRun
container_details = [
  {
    container_name      = "botify-bq",
    conatainer_location = "us-central1",
    container_labels = {
      "itpr"             = "it69",
      "costcenter"       = "610",
      "owner"            = "seam",
      "application"      = "botify-bq",
      "applicationname"  = "digital-seo-prod",
      "environment"      = "prod",
      "reportingsegment" = "retail_ltc"
    },
    container_cpu       = 1,
    container_memory    = "2048Mi",
    command_list        = [],
    container_args      = ["--set-env-vars=[APP_DEPLOY_ENV=prod]"],
    container_port      = 8080,
    container_port_name = "http1",
    container_image     = "gcr.io/digital-prod/jobs/botify-bq:0811.1",
    environment_variables = [
      {
        "name" : "SOURCE",
        "value" : "local"
      }
    ],
    vpc_access = {
      "connector" = "projects/digital-seo-prod/locations/us-central1/connectors/seo-vpc-prod-connector",
      "egress"    = "private-ranges-only" # value should be either "private-ranges-only" or "all-traffic"
    },
    ingress               = "all",
    allow_public_access   = false,
    container_concurrency = 80,
    request_timeout       = 3600
  },
  {
    container_name      = "seo-portal",
    conatainer_location = "us-central1",
    container_labels = {
      "itpr"             = "itpr69",
      "costcenter"       = "910",
      "owner"            = "seoteam",
      "application"      = "seo-portal",
      "applicationname"  = "digital-seo-prod",
      "environment"      = "prod",
      "reportingsegment" = "retail_ltc"
    },
    container_cpu       = 1,
    container_memory    = "4096Mi",
    command_list        = [],
    container_args      = ["--set-env-vars=[APP_DEPLOY_ENV=prod]"],
    container_port      = 8080,
    container_port_name = "http1",
    container_image     = "gcr.io/digital-seo-prod/seo-portal/seo-portal:08215",
    environment_variables = [
      {
        "name" : "SOURCE",
        "value" : "local"
      }
    ],
    vpc_access = {
      "connector" = "projects/digital-seo-prod/locations/us-central1/connectors/seo-vpc-prod-connector",
      "egress"    = "private-ranges-only" # value should be either "private-ranges-only" or "all-traffic"
    },
    ingress               = "all",
    allow_public_access   = true,
    container_concurrency = 80,
    request_timeout       = 3600
  },
  {
    container_name      = "adobe-bq",
    conatainer_location = "us-central1",
    container_labels = {
      "itpr"             = "itpr069",
      "costcenter"       = "90",
      "owner"            = "seoteam",
      "application"      = "adobe-bq",
      "applicationname"  = "digital-seo-prod",
      "environment"      = "prod",
      "reportingsegment" = "retail_ltc"
    },
    container_cpu       = 1,
    container_memory    = "2048Mi",
    command_list        = [],
    container_args      = ["--set-env-vars=[APP_DEPLOY_ENV=prod]"],
    container_port      = 8080,
    container_port_name = "http1",
    container_image     = "gcr.io/digital-seo-prod/jobs/adobe-bq:08122238",
    environment_variables = [
      {
        "name" : "SOURCE",
        "value" : "local"
      }
    ],
    vpc_access = {
      "connector" = "projects/digital-seo-prod/locations/us-central1/connectors/seo-vpc-prod-connector",
      "egress"    = "private-ranges-only" # value should be either "private-ranges-only" or "all-traffic"
    },
    ingress               = "all",
    allow_public_access   = false,
    container_concurrency = 80,
    request_timeout       = 3600
  },
  {
    container_name      = "gsc-bq",
    conatainer_location = "us-central1",
    container_labels = {
      "itpr"             = "itp9",
      "costcenter"       = "90",
      "owner"            = "seoteam",
      "application"      = "gsc-bq",
      "applicationname"  = "digital-seo-prod",
      "environment"      = "prod",
      "reportingsegment" = "retail_ltc"
    },
    container_cpu       = 1,
    container_memory    = "2048Mi",
    command_list        = [],
    container_args      = ["--set-env-vars=[APP_DEPLOY_ENV=prod]"],
    container_port      = 8080,
    container_port_name = "http1",
    container_image     = "gcr.io/digital-seo-prod/jobs/gsc-bq:08248",
    environment_variables = [
      {
        "name" : "SOURCE",
        "value" : "local"
      }
    ],
    vpc_access = {
      "connector" = "projects/digital-seo-prod/locations/us-central1/connectors/seo-vpc-prod-connector",
      "egress"    = "private-ranges-only" # value should be either "private-ranges-only" or "all-traffic"
    },
    ingress               = "all",
    allow_public_access   = false,
    container_concurrency = 80,
    request_timeout       = 3600
  },
  {
    container_name      = "sitemaps-gscs",
    conatainer_location = "us-central1",
    container_labels = {
      "itpr"             = "itpr09",
      "costcenter"       = "90",
      "owner"            = "seoteam",
      "application"      = "sitemaps-gscs",
      "applicationname"  = "digital-seo-prod",
      "environment"      = "prod",
      "reportingsegment" = "retail_ltc"
    },
    container_cpu       = 1,
    container_memory    = "2048Mi",
    command_list        = [],
    container_args      = ["--set-env-vars=[APP_DEPLOY_ENV=prod]"],
    container_port      = 8080,
    container_port_name = "http1",
    container_image     = "gcr.io/digital-seo-prod/jobs/sitemaps-gcs:08122255",
    environment_variables = [
      {
        "name" : "SOURCE",
        "value" : "local"
      }
    ],
    vpc_access = {
      "connector" = "projects/digital-seo-prod/locations/us-central1/connectors/seo-vpc-prod-connector",
      "egress"    = "private-ranges-only" # value should be either "private-ranges-only" or "all-traffic"
    },
    ingress               = "all",
    allow_public_access   = false,
    container_concurrency = 80,
    request_timeout       = 3600
  },
  {
    container_name      = "stat-bq",
    conatainer_location = "us-central1",
    container_labels = {
      "itpr"             = "itpr09",
      "costcenter"       = "90",
      "owner"            = "seoteam",
      "application"      = "stat-bq",
      "applicationname"  = "digital-seo-prod",
      "environment"      = "prod",
      "reportingsegment" = "retail_ltc"
    },
    container_cpu       = 1,
    container_memory    = "2048Mi",
    command_list        = [],
    container_args      = ["--set-env-vars=[APP_DEPLOY_ENV=prod]"],
    container_port      = 8080,
    container_port_name = "http1",
    container_image     = "gcr.io/digital-seo-prod/jobs/stat-bq:08122305",
    environment_variables = [
      {
        "name" : "SOURCE",
        "value" : "local"
      }
    ],
    vpc_access = {
      "connector" = "projects/digital-seo-prod/locations/us-central1/connectors/seo-vpc-prod-connector",
      "egress"    = "private-ranges-only" # value should be either "private-ranges-only" or "all-traffic"
    },
    ingress               = "all",
    allow_public_access   = false,
    container_concurrency = 80,
    request_timeout       = 3600
  },
  {
    container_name      = "storedata-bq",
    conatainer_location = "us-central1",
    container_labels = {
      "itpr"             = "itpr09",
      "costcenter"       = "90",
      "owner"            = "seoteam",
      "application"      = "storedata-bq",
      "applicationname"  = "digital-seo-prod",
      "environment"      = "prod",
      "reportingsegment" = "retail_ltc"
    },
    container_cpu       = 1,
    container_memory    = "2048Mi",
    command_list        = [],
    container_args      = ["--set-env-vars=[APP_DEPLOY_ENV=prod]"],
    container_port      = 8080,
    container_port_name = "http1",
    container_image     = "gcr.io/digital-seo-prod/jobs/storedata-bq:08130829",
    environment_variables = [
      {
        "name" : "SOURCE",
        "value" : "local"
      }
    ],
    vpc_access = {
      "connector" = "projects/digital-seo-prod/locations/us-central1/connectors/seo-vpc-prod-connector",
      "egress"    = "private-ranges-only" # value should be either "private-ranges-only" or "all-traffic"
    },
    ingress               = "all",
    allow_public_access   = false,
    container_concurrency = 80,
    request_timeout       = 3600
  }
]




#########################################################################################################################
#EXAMPLE:
#   {
#     container_name   = "hello-service1",
#     conatainer_location   = var.region,
#     container_labels = {
#     "env" = "dev"
#      },
#     container_cpu         = 4,
#     container_memory      = "8Gi",
#     command_list          = [],
#     container_args        = [],
#     container_port        = 8080,
#     container_port_name   = null,
#     container_image       = "us-docker.pkg.dev/cloudrun/container/hello",
#     environment_variables = [{ "name" : "SOURCE", "value" : "remote" }],
#     vpc_access = null,
#     allow_public_access   = false,
#     container_concurrency = 60,
#     request_timeout       = 50,
#     ingress               = "all"
# }
