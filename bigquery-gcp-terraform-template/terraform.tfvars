project_id      = "digital-prod"
region          = "us-central1"
zone            = "us-central1-b"
#bigquery
bigquery_dataset_list = [
  {
    dataset_id                  = "schrute_farms",
    description                 = "schrute_farms dataset"
    default_table_expiration_ms = 3600000,
    location                    = "US",
    friendly_name               = "sampledataset1",
    labels = {
      "costcenter"  = "98610"
      "owner"       = "seo"
      "application" = "digitaldataset"
    },
    bigquery_encryption_key = [],
    access = [
      {
        role          = "roles/bigquery.dataOwner"
        user_by_email = "infrastructure-dig-prod@digital-prod.iam.gserviceaccount.com"
      },
      {
        role          = "roles/bigquery.dataEditor"
        user_by_email = "dig-user-prod@digital-prod.iam.gserviceaccount.com"
      }
    ]
  },
  {
    dataset_id                  = "dataset_2",
    description                 = "This is dataset_2 created in prod gcp project to support optimization"
    default_table_expiration_ms = null,
    location                    = "US",
    friendly_name               = "sampledataset2",
    labels = {
      "costcenter"  = "98610"
      "owner"       = "team"
      "application" = "dataset_dig"
    },
    bigquery_encryption_key = [],
    access = [
      {
        role          = "roles/bigquery.dataOwner"
        user_by_email = "infrastructure-dig-prod@digital-prod.iam.gserviceaccount.com"
      },
      {
        role          = "roles/bigquery.dataEditor"
        user_by_email = "dig-user-prod@digital-prod.iam.gserviceaccount.com"
      }
    ]
  }
]
