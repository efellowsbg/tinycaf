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
}

# pre-requisites
servers = {
  srv_web_01 = {
    name        = "web-01"
    server_type = "cx22"
    image       = "ubuntu-24.04"
    location    = "fsn1"
  }
}
