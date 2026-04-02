# Load Balancer Target Module

Manages an hcloud_load_balancer_target resource.

## Usage

```hcl
load_balancer_targets = {
  lbt_web_01 = {
    load_balancer_ref = "lb_web"
    type              = "server"
    server_ref        = "srv_web_01"
    use_private_ip    = true
  }
}
```

## Inputs

| Name | Description | Required |
|------|-------------|----------|
| load_balancer_ref | Reference key to the load balancer | Yes |
| type | Target type: server, label_selector, or ip | Yes |
| server_ref | Server reference key (if type=server) | No |
| label_selector | Label selector (if type=label_selector) | No |
| ip | IP address (if type=ip) | No |
| use_private_ip | Use private IP for the target | No |
