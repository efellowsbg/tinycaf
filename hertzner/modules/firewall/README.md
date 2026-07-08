# Firewall Module

Manages an hcloud_firewall resource.

## Usage

```hcl
firewalls = {
  fw_web = {
    name = "fw-web"
    rules = {
      allow_ssh = {
        direction  = "in"
        protocol   = "tcp"
        port       = "22"
        source_ips = ["0.0.0.0/0", "::/0"]
        description = "Allow SSH"
      }
      allow_http = {
        direction  = "in"
        protocol   = "tcp"
        port       = "80"
        source_ips = ["0.0.0.0/0", "::/0"]
        description = "Allow HTTP"
      }
      allow_https = {
        direction  = "in"
        protocol   = "tcp"
        port       = "443"
        source_ips = ["0.0.0.0/0", "::/0"]
        description = "Allow HTTPS"
      }
    }
  }
}
```

## Inputs

| Name | Description | Required |
|------|-------------|----------|
| name | Firewall name | Yes |
| labels | Key-value label pairs | No |
| rules | Map of firewall rules | No |
| apply_to | Map of targets to apply firewall to | No |
