output "cloud_storage_bucket_urls" {
  value = google_storage_bucket.bucket.url
}

output "bucket_name" {
  value = google_storage_bucket.bucket.name
}
