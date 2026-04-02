firewalls = {
  fw_web = {
    name = "fw-web"
    labels = {
      role = "web"
    }
    rules = {
      allow_ssh = {
        direction   = "in"
        protocol    = "tcp"
        port        = "22"
        source_ips  = ["0.0.0.0/0", "::/0"]
        description = "Allow SSH"
      }
      allow_http = {
        direction   = "in"
        protocol    = "tcp"
        port        = "80"
        source_ips  = ["0.0.0.0/0", "::/0"]
        description = "Allow HTTP"
      }
      allow_https = {
        direction   = "in"
        protocol    = "tcp"
        port        = "443"
        source_ips  = ["0.0.0.0/0", "::/0"]
        description = "Allow HTTPS"
      }
      allow_icmp = {
        direction   = "in"
        protocol    = "icmp"
        source_ips  = ["0.0.0.0/0", "::/0"]
        description = "Allow ICMP"
      }
    }
  }
}
