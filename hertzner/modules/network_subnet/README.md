# Network Subnet Module

Manages an hcloud_network_subnet resource.

## Usage

```hcl
network_subnets = {
  subnet_main = {
    network_ref  = "net_main"
    type         = "cloud"
    ip_range     = "10.0.1.0/24"
    network_zone = "eu-central"
  }
}
```

## Inputs

| Name | Description | Required |
|------|-------------|----------|
| network_ref | Reference key to the parent network | Yes |
| type | Subnet type: server, cloud, or vswitch | Yes |
| ip_range | IP range in CIDR notation | Yes |
| network_zone | Network zone (e.g. eu-central) | Yes |
| vswitch_id | vSwitch ID (required if type is vswitch) | No |
| network_lz_key | Landing zone key for network (defaults to current) | No |
