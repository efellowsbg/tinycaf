networks = {
  net_main = {
    name     = "network-main"
    ip_range = "10.0.0.0/16"
  }
}

network_subnets = {
  subnet_servers = {
    network_ref  = "net_main"
    type         = "cloud"
    ip_range     = "10.0.1.0/24"
    network_zone = "eu-central"
  }
}

servers = {
  srv_app_01 = {
    name        = "app-01"
    server_type = "cx22"
    image       = "ubuntu-24.04"
    location    = "fsn1"
    ssh_keys    = ["deploy-key"]
    labels = {
      role = "app"
    }
    public_net = {
      ipv4_enabled = false
      ipv6_enabled = false
    }
    networks = {
      main = {
        network_ref = "net_main"
        ip          = "10.0.1.10"
      }
    }
  }
}

ssh_keys = {
  key_deploy = {
    name       = "deploy-key"
    public_key = "ssh-rsa AAAAB3... user@host"
  }
}
