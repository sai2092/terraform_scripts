output "load-balancer-ip-address" {
  value = google_compute_global_forwarding_rule.kibana_forwarding_rule.ip_address
}