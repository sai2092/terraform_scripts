locals {
  no_of_instances = length(var.reserved_ip_address)
}

resource "google_compute_firewall" "health-check-rule" {
  name    = "kibana-health-check-rule"
  network = var.network
  allow {
    protocol = "tcp"
    ports    = var.ports_list
  }
  source_ranges = var.health_check_network_source_range
  target_tags   = ["allowhealthcheck"]
}

resource "google_compute_firewall" "kibana-rule" {
  name    = "kibana-rule"
  network = var.network
  allow {
    protocol = "tcp"
    ports    = var.ports_list
  }
  source_ranges = var.kibana_network_source_range
  target_tags   = ["kibana"]
}

resource "google_compute_address" "kibana_internal_ips" {
  count        = local.no_of_instances
  name         = "kibana-static-ip-${count.index + 1}"
  subnetwork   = var.network
  address_type = "INTERNAL"
  address      = var.reserved_ip_address[count.index]
}

resource "google_compute_instance" "kibana" {
  count        = local.no_of_instances
  name         = "${var.name_prefix}-${count.index + 1}"
  machine_type = var.machine_type
  tags         = var.network_tags
  labels       = var.labels
  boot_disk {
    initialize_params {
      image = var.image_type
      type  = var.disk_type
      size  = var.disk_size
    }
  }
  network_interface {
    network    = var.network
    subnetwork = var.subnetwork
    network_ip = google_compute_address.kibana_internal_ips[count.index].address
    # access_config {
    #
    # }
  }
  service_account {
    scopes = ["storage-rw", "compute-rw"]
  }
  metadata = {
    startup-script = <<SCRIPT
    sudo apt-get -y update
    sudo apt-get -y install openjdk-11-jre
    sudo wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
    sudo apt-get -y install apt-transport-https
    echo "deb https://artifacts.elastic.co/packages/7.x/apt stable main" | sudo tee /etc/apt/sources.list.d/elastic-7.x.list
    sudo apt-get -y update && sudo apt-get install kibana=${var.kibana_version}
    sudo su
    mkdir /var/log/kibana
    chmod -R 777 /var/log/kibana
    mv /etc/kibana/kibana.yml /etc/kibana/kibana.yml.orig
    cat <<EOT >> /etc/kibana/kibana.yml
elasticsearch.hosts: ["http://${var.elastic_cluster_master}:9200"]
server.name: "${var.name_prefix}-1"
server.host: "0.0.0.0"
server.port: 5601
kibana.index: ".kibana"
logging.dest: /var/log/kibana/kibana.log
logging.verbose: true
elasticsearch.username: "elastic"
EOT
    # added sleep to ensure certicates are copied to cloud storage from elasticsearch instance
    sleep 120
    systemctl daemon-reload
    systemctl enable kibana
    systemctl start kibana
    /usr/share/kibana/bin/kibana-keystore create --allow-root
    echo "${var.elastic_user_password}" | /usr/share/kibana/bin/kibana-keystore add -xf elasticsearch.password --allow-root
    systemctl restart kibana
    SCRIPT
  }
}

resource "google_compute_instance_group" "kibana-instance-group" {
  name      = "kibana-instance-group"
  instances = google_compute_instance.kibana.*.self_link
  named_port {
    name = "http"
    port = 5601
  }
}
