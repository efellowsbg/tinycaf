# DNS Zone Record Module

Manages an hcloud_zone_record resource. Use hcloud_zone_rrset where possible instead.

## Usage

```hcl
zone_records = {
  rec_www = {
    zone_ref = "zone_example"
    name     = "www"
    type     = "A"
    value    = "1.2.3.4"
  }
}
```

## Inputs

| Name | Description | Required |
|------|-------------|----------|
| zone_ref | Reference key to the DNS zone | Yes |
| name | Record name | Yes |
| type | Record type (A, AAAA, CNAME, etc.) | Yes |
| value | Record value | Yes |
| comment | Record comment | No |
