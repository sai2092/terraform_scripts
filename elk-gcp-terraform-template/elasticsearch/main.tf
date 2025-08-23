locals {
  no_of_instances = length(var.reserved_ip_address)
}

resource "google_compute_disk" "elastic-disk" {
  count = local.no_of_instances
  name  = "elastic-disk-${count.index + 1}-data"
  type  = var.data_disk_type
  size  = var.data_disk_size
}

resource "google_compute_firewall" "elasticsearch-rule" {
  name    = "elastic-rule"
  network = var.network
  allow {
    protocol = "tcp"
    ports    = var.ports_list
  }
  source_ranges = var.elastic_network_source_range
  target_tags   = ["elastic"]
}


resource "google_compute_address" "elastic_internal_ips" {
  count        = local.no_of_instances
  name         = "elastic-static-ip-${count.index + 1}"
  subnetwork   = var.network
  address_type = "INTERNAL"
  address      = var.reserved_ip_address[count.index]
}

resource "google_compute_instance" "elastic" {
  count        = local.no_of_instances
  depends_on   = [google_compute_instance.elastic[0]]
  name         = "${var.name_prefix}-${count.index + 1}"
  machine_type = var.machine_type
  tags         = var.network_tags
  labels       = var.labels
  boot_disk {
    auto_delete = true
    mode        = "READ_WRITE"
    initialize_params {
      image = var.image_type
      type  = var.disk_type
      size  = var.disk_size
    }
  }
  attached_disk {
    source = element(google_compute_disk.elastic-disk.*.self_link, count.index)
    mode   = "READ_WRITE"
  }
  network_interface {
    network    = var.network
    subnetwork = var.subnetwork
    network_ip = google_compute_address.elastic_internal_ips[count.index].address
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
  sudo apt-get -y install unzip
  sudo wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
  sudo apt-get -y install apt-transport-https
  echo "deb https://artifacts.elastic.co/packages/7.x/apt stable main" | sudo tee /etc/apt/sources.list.d/elastic-7.x.list
  sudo apt-get -y update && sudo apt-get install elasticsearch=${var.elastic_version}
  sudo su
  mv /etc/elasticsearch/elasticsearch.yml /etc/elasticsearch/elasticsearch.yml.orig
  echo "cluster.name: \"elasticsearch-cluster\"" >> /etc/elasticsearch/elasticsearch.yml
  echo "node.name: \"${var.name_prefix}-${count.index + 1}\"" >> /etc/elasticsearch/elasticsearch.yml
  echo "path.data: $MNT_DIR/elasticsearch" >> /etc/elasticsearch/elasticsearch.yml
  echo "path.logs: /var/log/elasticsearch/"  >> /etc/elasticsearch/elasticsearch.yml
  echo "network.host: \"0.0.0.0\"" >> /etc/elasticsearch/elasticsearch.yml
  if [ ${count.index} -eq 0 ]; then
  echo "node.master: true" >> /etc/elasticsearch/elasticsearch.yml
  fi
  i=0
  nodeList=""
  while [ $i -lt ${local.no_of_instances} ]; do
    i=`expr $i + 1`
    if [ $i -eq 1 ];then
      nodeList="\"${var.name_prefix}-$i\""
    else
      nodeList="$nodeList,\"${var.name_prefix}-$i\""
    fi
  done
  echo "discovery.seed_hosts: [ $nodeList ]" >> /etc/elasticsearch/elasticsearch.yml
  echo "cluster.initial_master_nodes: [ \"${var.name_prefix}-1\" ]" >> /etc/elasticsearch/elasticsearch.yml
  echo "xpack.security.enabled: true" >> /etc/elasticsearch/elasticsearch.yml
  echo "xpack.security.transport.ssl.enabled: true" >> /etc/elasticsearch/elasticsearch.yml
  echo "xpack.security.transport.ssl.key: certs/${var.name_prefix}-${count.index + 1}.key" >> /etc/elasticsearch/elasticsearch.yml
  echo "xpack.security.transport.ssl.certificate: certs/${var.name_prefix}-${count.index + 1}.crt" >> /etc/elasticsearch/elasticsearch.yml
  echo "xpack.security.transport.ssl.certificate_authorities: certs/ca.crt" >> /etc/elasticsearch/elasticsearch.yml
  echo "xpack.security.transport.ssl.verification_mode: certificate" >> /etc/elasticsearch/elasticsearch.yml
  if [ ${count.index} -eq 0 ]; then
    echo "instances:" > /tmp/instances.yml
    i=0
    while [ $i -lt ${local.no_of_instances} ]; do
      i=`expr $i + 1`
      echo "   - name: \"${var.name_prefix}-$i\"" >> /tmp/instances.yml
      echo "     dns: [\"${var.name_prefix}-$i\"]" >> /tmp/instances.yml
    done
    /usr/share/elasticsearch/bin/elasticsearch-certutil cert --keep-ca-key --pem --in /tmp/instances.yml --out /tmp/certs.zip
    unzip /tmp/certs.zip -d "/tmp/certificates"
    gsutil cp -r /tmp/certificates ${var.gcs_folder}
  else
    # added sleep to ensure certicates are copied to cloud storage from elasticsearch instance
    sleep 120
  fi
  mkdir /etc/elasticsearch/certs
  gsutil cp -r ${var.gcs_folder}/ca/* /etc/elasticsearch/certs
  gsutil cp -r ${var.gcs_folder}/${var.name_prefix}-${count.index + 1}/* /etc/elasticsearch/certs

  systemctl daemon-reload
  systemctl enable elasticsearch
  systemctl start elasticsearch
  echo "${var.elastic_user_password}" | /usr/share/elasticsearch/bin/elasticsearch-keystore add -xf bootstrap.password
  systemctl restart elasticsearch
    SCRIPT
  }
}
