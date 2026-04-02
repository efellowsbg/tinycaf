# Floating IP Assignment Module

Manages an hcloud_floating_ip_assignment resource.

## Usage

```hcl
floating_ip_assignments = {
  fipa_web = {
    floating_ip_ref = "fip_web"
    server_ref      = "srv_web_01"
  }
}
```

## Inputs

| Name | Description | Required |
|------|-------------|----------|
| floating_ip_ref | Reference key to the floating IP | Yes |
| server_ref | Reference key to the server | Yes |
| floating_ip_lz_key | Landing zone key for floating IP | No |
| server_lz_key | Landing zone key for server | No |
