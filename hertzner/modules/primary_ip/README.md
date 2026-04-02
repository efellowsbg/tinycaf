# Primary IP Module

Manages an hcloud_primary_ip resource.

## Usage

```hcl
primary_ips = {
  pip_web = {
    name          = "primary-ip-web"
    type          = "ipv4"
    assignee_type = "server"
    auto_delete   = false
    location      = "fsn1"
  }
}
```

## Inputs

| Name | Description | Required |
|------|-------------|----------|
| name | Primary IP name | Yes |
| type | IP type: ipv4 or ipv6 | Yes |
| assignee_type | Assignee type (default: server) | No |
| auto_delete | Auto delete when unassigned | No |
| location | Location name | No |
| datacenter | Datacenter name (deprecated, use location) | No |
| labels | Key-value label pairs | No |
| delete_protection | Enable delete protection | No |
