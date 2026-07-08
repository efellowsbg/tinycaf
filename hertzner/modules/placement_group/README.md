# Placement Group Module

Manages an hcloud_placement_group resource.

## Usage

```hcl
placement_groups = {
  pg_web = {
    name = "pg-web-spread"
    type = "spread"
  }
}
```

## Inputs

| Name | Description | Required |
|------|-------------|----------|
| name | Placement group name | Yes |
| type | Placement group type (default: spread) | No |
| labels | Key-value label pairs | No |
