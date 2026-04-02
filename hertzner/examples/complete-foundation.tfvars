# Complete Hetzner Cloud Foundation
# Demonstrates a realistic minimal landing zone deployment

global_settings = {
  labels = {
    environment = "production"
    managed_by  = "terraform"
    project     = "tinycaf"
  }
}

# --- Networking ---

networks = {
  net_main = {
    name     = "net-production"
    ip_range = "10.0.0.0/16"
  }
}

network_subnets = {
  subnet_web = {
    network_ref  = "net_main"
    type         = "cloud"
    ip_range     = "10.0.1.0/24"
    network_zone = "eu-central"
  }
  subnet_app = {
    network_ref  = "net_main"
    type         = "cloud"
    ip_range     = "10.0.2.0/24"
    network_zone = "eu-central"
  }
  subnet_db = {
    network_ref  = "net_main"
    type         = "cloud"
    ip_range     = "10.0.3.0/24"
    network_zone = "eu-central"
  }
}

# --- Security ---

ssh_keys = {
  key_deploy = {
    name       = "deploy-key"
    public_key = "ssh-rsa AAAAB3... deploy@infra"
  }
}

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
        source_ips  = ["10.0.0.0/16"]
        description = "Allow SSH from private network"
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
    }
  }
  fw_internal = {
    name = "fw-internal"
    labels = {
      role = "internal"
    }
    rules = {
      allow_ssh = {
        direction   = "in"
        protocol    = "tcp"
        port        = "22"
        source_ips  = ["10.0.0.0/16"]
        description = "Allow SSH from private network"
      }
      allow_internal = {
        direction   = "in"
        protocol    = "tcp"
        port        = "1-65535"
        source_ips  = ["10.0.0.0/16"]
        description = "Allow all TCP from private network"
      }
    }
  }
}

# --- Compute ---

placement_groups = {
  pg_web = {
    name = "pg-web-spread"
    type = "spread"
  }
}

servers = {
  srv_web_01 = {
    name        = "web-01"
    server_type = "cx22"
    image       = "ubuntu-24.04"
    location    = "fsn1"
    ssh_keys    = ["deploy-key"]
    labels = {
      role = "web"
    }
    placement_group_ref = "pg_web"
    firewall_ids_ref    = ["fw_web"]
    public_net = {
      ipv4_enabled = true
      ipv6_enabled = true
    }
    networks = {
      main = {
        network_ref = "net_main"
        ip          = "10.0.1.10"
      }
    }
  }
  srv_web_02 = {
    name        = "web-02"
    server_type = "cx22"
    image       = "ubuntu-24.04"
    location    = "fsn1"
    ssh_keys    = ["deploy-key"]
    labels = {
      role = "web"
    }
    placement_group_ref = "pg_web"
    firewall_ids_ref    = ["fw_web"]
    public_net = {
      ipv4_enabled = true
      ipv6_enabled = true
    }
    networks = {
      main = {
        network_ref = "net_main"
        ip          = "10.0.1.11"
      }
    }
  }
  srv_app_01 = {
    name        = "app-01"
    server_type = "cx32"
    image       = "ubuntu-24.04"
    location    = "fsn1"
    ssh_keys    = ["deploy-key"]
    labels = {
      role = "app"
    }
    firewall_ids_ref = ["fw_internal"]
    public_net = {
      ipv4_enabled = false
      ipv6_enabled = false
    }
    networks = {
      main = {
        network_ref = "net_main"
        ip          = "10.0.2.10"
      }
    }
  }
}

# --- Storage ---

volumes = {
  vol_app_data = {
    name       = "vol-app-data"
    size       = 50
    server_ref = "srv_app_01"
    format     = "ext4"
    automount  = true
    labels = {
      role = "app-data"
    }
  }
}

# --- Load Balancing ---

load_balancers = {
  lb_web = {
    name               = "lb-web"
    load_balancer_type = "lb11"
    location           = "fsn1"
    algorithm = {
      type = "round_robin"
    }
    labels = {
      role = "web"
    }
  }
}

load_balancer_services = {
  lbs_http = {
    load_balancer_ref = "lb_web"
    protocol          = "http"
    listen_port       = 80
    destination_port  = 80
    health_check = {
      protocol = "http"
      port     = 80
      interval = 15
      timeout  = 10
      retries  = 3
      http = {
        path         = "/health"
        status_codes = ["2??", "3??"]
      }
    }
  }
}

load_balancer_targets = {
  lbt_web_01 = {
    load_balancer_ref = "lb_web"
    type              = "server"
    server_ref        = "srv_web_01"
    use_private_ip    = true
  }
  lbt_web_02 = {
    load_balancer_ref = "lb_web"
    type              = "server"
    server_ref        = "srv_web_02"
    use_private_ip    = true
  }
}

load_balancer_networks = {
  lbn_web = {
    load_balancer_ref = "lb_web"
    network_ref       = "net_main"
    ip                = "10.0.1.100"
  }
}
