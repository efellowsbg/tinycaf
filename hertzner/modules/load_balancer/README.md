# Load Balancer Module

Manages an hcloud_load_balancer resource.

## Usage

```hcl
load_balancers = {
  lb_web = {
    name               = "lb-web"
    load_balancer_type = "lb11"
    location           = "fsn1"
    algorithm = {
      type = "round_robin"
    }
  }
}
```

## Inputs

| Name | Description | Required |
|------|-------------|----------|
| name | Load balancer name | Yes |
| load_balancer_type | Load balancer type (e.g. lb11) | Yes |
| location | Location (required if no network_zone) | No |
| network_zone | Network zone (required if no location) | No |
| algorithm | Algorithm configuration block | No |
| labels | Key-value label pairs | No |
| delete_protection | Enable delete protection | No |
