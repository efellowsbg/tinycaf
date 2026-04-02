# DNS Zone Module

Manages an hcloud_zone resource.

## Usage

```hcl
zones = {
  zone_example = {
    name = "example.com"
    mode = "primary"
    ttl  = 3600
  }
}
```

## Inputs

| Name | Description | Required |
|------|-------------|----------|
| name | Zone name (domain) | Yes |
| mode | Zone mode | Yes |
| ttl | Default TTL | No |
| labels | Key-value label pairs | No |
| delete_protection | Enable delete protection | No |
| primary_nameservers | Map of primary nameserver configurations | No |
