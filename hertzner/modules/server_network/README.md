# Server Network Module

Manages an hcloud_server_network resource.

## Usage

```hcl
server_networks = {
  srvnet_web_main = {
    server_ref  = "srv_web_01"
    network_ref = "net_main"
    ip          = "10.0.1.10"
  }
}
```

## Inputs

| Name | Description | Required |
|------|-------------|----------|
| server_ref | Reference key to the server | Yes |
| network_ref | Reference key to the network | No |
| subnet_ref | Reference key to the subnet | No |
| ip | IP address to assign | No |
| alias_ips | Set of alias IPs | No |
