# Load Balancer Network Module

Manages an hcloud_load_balancer_network resource.

## Usage

```hcl
load_balancer_networks = {
  lbn_web = {
    load_balancer_ref = "lb_web"
    network_ref       = "net_main"
    ip                = "10.0.1.100"
  }
}
```

## Inputs

| Name | Description | Required |
|------|-------------|----------|
| load_balancer_ref | Reference key to the load balancer | Yes |
| network_ref | Reference key to the network | No |
| subnet_ref | Reference key to the subnet | No |
| ip | IP address to assign | No |
| enable_public_interface | Enable public interface (default: true) | No |
