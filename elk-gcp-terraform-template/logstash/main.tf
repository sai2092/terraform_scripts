locals {
  no_of_instances = length(var.reserved_ip_address)
}

resource "google_compute_disk" "logstash-disk" {
  count = local.no_of_instances
  name  = "logstash-disk-${count.index + 1}-data"
  type  = var.data_disk_type
  size  = var.data_disk_size
}

resource "google_compute_firewall" "logstash-rule" {
  name    = "logstash-rule"
  network = var.network
  allow {
    protocol = "tcp"
    ports    = var.ports_list
  }
  source_ranges = var.logstash_network_source_range
  target_tags   = ["logstash"]
}

resource "google_compute_address" "logstash_internal_ips" {
  count        = local.no_of_instances
  name         = "logstash-static-ip-${count.index + 1}"
  subnetwork   = var.network
  address_type = "INTERNAL"
  address      = var.reserved_ip_address[count.index]
}

resource "google_compute_instance" "logstash" {
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
  attached_disk {
    source = element(google_compute_disk.logstash-disk.*.self_link, count.index)
    mode   = "READ_WRITE"
  }
  network_interface {
    network    = var.network
    subnetwork = var.subnetwork
    network_ip = google_compute_address.logstash_internal_ips[count.index].address
    # access_config {
    #
    # }
  }
  service_account {
    scopes = ["storage-rw", "compute-rw"]
  }
  metadata = {
    startup-script = <<SCRIPT
    #!/bin/bash
    set -euxo pipefail

    MNT_DIR=/mnt/data

    # Check if entry exists in fstab
    ENTRY_EXISTS=$(grep -q "$MNT_DIR" /etc/fstab; echo $?)
    if [[ $ENTRY_EXISTS -eq 0 ]]; then
      echo "$MNT_DIR is already mounted"
    else
      sudo mkfs.ext4 -m 0 -F -E lazy_itable_init=0,lazy_journal_init=0,discard /dev/sdb; \
      sudo mkdir -p $MNT_DIR
      sudo mount -o discard,defaults /dev/sdb $MNT_DIR
      sudo chmod -R 777 $MNT_DIR

      # Add fstab entry
      echo UUID=`sudo blkid -s UUID -o value /dev/sdb` $MNT_DIR ext4 discard,defaults,nofail 0 2 | sudo tee -a /etc/fstab
    fi

    sudo apt-get -y update
    sudo apt-get -y install openjdk-11-jre
    sudo wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
    sudo apt-get -y install apt-transport-https
    echo "deb https://artifacts.elastic.co/packages/7.x/apt stable main" | sudo tee /etc/apt/sources.list.d/elastic-7.x.list
    sudo apt-get -y update && sudo apt-get install logstash=${var.logstash_version}
    sudo su
    mv /etc/logstash/logstash.yml /etc/logstash/logstash.yml.orig
    cat <<EOF >/etc/logstash/logstash.yml
path.data: $MNT_DIR/logstash
path.logs: /var/log/logstash
http.host: 0.0.0.0
pipeline.ordered: auto
EOF
    cat <<EOF >/etc/logstash/conf.d/syslog.conf
input {
  file {
    path => ["/var/log/*.log", "/var/log/messages", "/var/log/syslog"]
    type => "syslog"
  }
}

output {
  elasticsearch {
    index => "syslog-demo"
      hosts => ["http://${var.elastic_cluster_master}:9200"]
      user => "elastic"
      password => "${var.elastic_user_password}"
  }
}
EOF
    # added sleep to ensure certicates are copied to cloud storage from elasticsearch instance
    sleep 120

    mkdir -p /etc/logstash/config/certs
    gsutil cp -r ${var.gcs_folder}/* /etc/logstash/config/certs
    systemctl daemon-reload
    systemctl enable logstash
    systemctl start logstash
    SCRIPT
  }
}
