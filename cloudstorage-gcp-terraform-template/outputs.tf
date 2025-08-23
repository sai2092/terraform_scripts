output "cloud_storage_bucket_urls" {
  value = { for name, bucket in google_storage_bucket.buckets :
    name => bucket.url
  }
}
