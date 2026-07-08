servers = {
  srv_web_01 = {
    name        = "web-01"
    server_type = "cx22"
    image       = "ubuntu-24.04"
    location    = "fsn1"
    ssh_keys    = ["deploy-key"]
    labels = {
      role        = "web"
      environment = "dev"
    }
    public_net = {
      ipv4_enabled = true
      ipv6_enabled = true
    }
  }
}

ssh_keys = {
  key_deploy = {
    name       = "deploy-key"
    public_key = "ssh-rsa AAAAB3... user@host"
  }
}
