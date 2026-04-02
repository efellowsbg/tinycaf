# Network Route Module

Manages an hcloud_network_route resource.

## Usage

```hcl
network_routes = {
  route_default = {
    network_ref = "net_main"
    destination = "10.100.1.0/24"
    gateway     = "10.0.1.1"
  }
}
```

## Inputs

| Name | Description | Required |
|------|-------------|----------|
| network_ref | Reference key to the parent network | Yes |
| destination | Destination network in CIDR notation | Yes |
| gateway | Gateway IP address | Yes |
| network_lz_key | Landing zone key for network (defaults to current) | No |
