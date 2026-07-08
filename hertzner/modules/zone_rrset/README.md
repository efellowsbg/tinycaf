# DNS Zone Record Set Module

Manages an hcloud_zone_rrset resource (preferred over zone_record).

## Usage

```hcl
zone_rrsets = {
  rrset_www = {
    zone_ref = "zone_example"
    name     = "www"
    type     = "A"
    ttl      = 300
    records = {
      primary = {
        value = "1.2.3.4"
      }
      secondary = {
        value   = "5.6.7.8"
        comment = "Failover IP"
      }
    }
  }
}
```

## Inputs

| Name | Description | Required |
|------|-------------|----------|
| zone_ref | Reference key to the DNS zone | Yes |
| name | Record name | Yes |
| type | Record type (A, AAAA, CNAME, etc.) | Yes |
| records | Map of record values | Yes |
| ttl | TTL in seconds | No |
| labels | Key-value label pairs | No |
| change_protection | Enable change protection | No |
