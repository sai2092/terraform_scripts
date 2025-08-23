output "cloud_run_urls" {
  value = [for service in google_cloud_run_service.default : service.status[0].url]
}
