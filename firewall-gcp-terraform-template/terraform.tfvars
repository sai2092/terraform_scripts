project_id      = "digital-prod"
region          = "us-central1"
zone            = "us-central1-b"
#Firewall
firewall_rule_network = "prod-vpc"
rules = [
  {
    name                    = "allow-iap"
    direction               = "INGRESS"
    priority                = 1000
    ranges                  = ["xx.yyy.zzz.0/20","xx.yyy.zzz.0/24","xx.yyy.zzz.0/24","xx.yyy.zzz.0/17"]
    source_tags             = null
    target_tags             = ["allow-iap"]
    allow = [
      {
       protocol = "tcp"
       ports    = ["22"]
      }
    ]
    deny = []
  }
]
