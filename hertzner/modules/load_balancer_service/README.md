# Load Balancer Service Module

Manages an hcloud_load_balancer_service resource.

## Usage

```hcl
load_balancer_services = {
  lbs_http = {
    load_balancer_ref = "lb_web"
    protocol          = "http"
    listen_port       = 80
    destination_port  = 80
    health_check = {
      protocol = "http"
      port     = 80
      http = {
        path         = "/health"
        status_codes = ["2??", "3??"]
      }
    }
  }
}
```

## Inputs

| Name | Description | Required |
|------|-------------|----------|
| load_balancer_ref | Reference key to the load balancer | Yes |
| protocol | Protocol: http, https, or tcp | Yes |
| listen_port | Listen port | No |
| destination_port | Destination port | No |
| proxyprotocol | Enable proxy protocol | No |
| http | HTTP configuration block | No |
| health_check | Health check configuration block | No |
