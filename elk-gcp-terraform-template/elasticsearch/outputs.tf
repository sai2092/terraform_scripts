output "master_name" {
  value = google_compute_instance.elastic[0].name
}