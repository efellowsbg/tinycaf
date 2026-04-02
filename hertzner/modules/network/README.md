# Network Module

Manages an hcloud_network resource.

## Usage

```hcl
networks = {
  net_main = {
    name     = "network-main"
    ip_range = "10.0.0.0/16"
    labels   = { environment = "production" }
  }
}
```

## Inputs

| Name | Description | Required |
|------|-------------|----------|
| name | Network name | Yes |
| ip_range | IP range in CIDR notation | Yes |
| labels | Key-value label pairs | No |
| delete_protection | Enable delete protection | No |
| expose_routes_to_vswitch | Expose routes to vSwitch | No |
