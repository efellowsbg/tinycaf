# Server Module

Manages an hcloud_server resource.

## Usage

```hcl
servers = {
  srv_web_01 = {
    name        = "web-01"
    server_type = "cx22"
    image       = "ubuntu-24.04"
    location    = "fsn1"
    ssh_keys    = ["my-ssh-key"]
    labels      = { role = "web" }

    public_net = {
      ipv4_enabled = true
      ipv6_enabled = true
    }

    networks = {
      net_main = {
        network_ref = "net_main"
        ip          = "10.0.1.10"
      }
    }
  }
}
```

## Inputs

| Name | Description | Required |
|------|-------------|----------|
| name | Server name | Yes |
| server_type | Server type (e.g. cx22, cx32) | Yes |
| image | Image name or ID | Yes |
| location | Location name | No |
| ssh_keys | List of SSH key names/IDs | No |
| user_data | Cloud-Init user data | No |
| labels | Key-value label pairs | No |
| backups | Enable backups | No |
| firewall_ids_ref | List of firewall reference keys | No |
| placement_group_ref | Placement group reference key | No |
| public_net | Public network configuration block | No |
| networks | Map of network attachments | No |
| delete_protection | Enable delete protection | No |
| rebuild_protection | Enable rebuild protection | No |
