resource "google_compute_health_check" "health-check" {
  name               = var.health_check_name
  description        = var.health_check_description
  check_interval_sec = 60
  timeout_sec        = 60
  tcp_health_check {
    port = "5601"
  }
}

resource "google_compute_backend_service" "backend_service" {
  name            = var.backend_service_name
  port_name       = "http"
  protocol        = "HTTP"
  security_policy = var.security_policy

  backend {
    group = var.instance_group
  }

  health_checks = [
    google_compute_health_check.health-check.id
  ]
}

resource "google_compute_url_map" "url_map" {
  name            = "kibana-load-balancer"
  default_service = google_compute_backend_service.backend_service.self_link
}

resource "google_compute_target_https_proxy" "target_https_proxy" {
  name             = "https-proxy"
  url_map          = google_compute_url_map.url_map.self_link
  ssl_certificates = var.ssl_certificate_ids
}

resource "google_compute_global_forwarding_rule" "kibana_forwarding_rule" {
  provider   = google-beta
  name       = "kibana-forwarding-rule"
  target     = google_compute_target_https_proxy.target_https_proxy.self_link
  port_range = "443"
  ip_address = var.elkglb_external_ip_address
  project    = var.project
  labels = var.labels
}
