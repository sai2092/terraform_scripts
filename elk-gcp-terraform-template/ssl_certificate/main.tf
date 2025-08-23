resource "google_compute_ssl_certificate" "ssl_certificate" {
  name        = var.ssl_certificate_name
  private_key = file("${path.module}/certs/private.key")
  certificate = file("${path.module}/certs/cacerts.crt")

  lifecycle {
    create_before_destroy = true
  }
}