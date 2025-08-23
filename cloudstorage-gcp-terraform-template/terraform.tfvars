project_id      = "digital-rx-pt"
region          = "us-east4"
zone            = "us-east4-a"
#GCS
bucket_list = [
  {
    bucket_name                      = "digital-rx-pt-terraform",
    bucket_location                  = "US",
    bucket_storage_class             = "Standard",
    lifecycle_delete_age_rules       = [],
    lifecycle_storageclass_age_rules = [],
    uniform_bucket_access            = true,
    bucket_encryption_key            = [],
    requester_pays_enabled           = false,
    bucket_labels = {
      "itpr"        = "itpr4"
      "costcenter"  = "97"
      "owner"       = "pbmteam"
      "application" = "terraform"
    },
    access = [
      {
        role    = "roles/storage.objectCreator",
        members = ["serviceAccount:dig-seo-botify-user-prod@digital-seo-dev.iam.gserviceaccount.com"]
      },
      {
        role    = "roles/storage.objectAdmin",
        members = ["serviceAccount:infrastructure-seo-prod@digital-seo-prod.iam.gserviceaccount.com"]
      }
    ]
  }
]