# Floating IP Module

Manages an hcloud_floating_ip resource.

## Usage

```hcl
floating_ips = {
  fip_web = {
    name          = "floating-ip-web"
    type          = "ipv4"
    home_location = "fsn1"
    description   = "Web frontend floating IP"
  }
}
```

## Inputs

| Name | Description | Required |
|------|-------------|----------|
| type | IP type: ipv4 or ipv6 | Yes |
| name | Floating IP name | No |
| description | Description | No |
| home_location | Home location | No |
| labels | Key-value label pairs | No |
| delete_protection | Enable delete protection | No |
