networks = {
  net_main = {
    name     = "network-main"
    ip_range = "10.0.0.0/16"
    labels = {
      environment = "dev"
    }
  }
}

network_subnets = {
  subnet_servers = {
    network_ref  = "net_main"
    type         = "cloud"
    ip_range     = "10.0.1.0/24"
    network_zone = "eu-central"
  }
  subnet_lb = {
    network_ref  = "net_main"
    type         = "cloud"
    ip_range     = "10.0.2.0/24"
    network_zone = "eu-central"
  }
}

network_routes = {
  route_vpn = {
    network_ref = "net_main"
    destination = "10.100.0.0/16"
    gateway     = "10.0.1.1"
  }
}
