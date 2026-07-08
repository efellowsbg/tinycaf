# Snapshot Module

Manages an hcloud_snapshot resource.

## Usage

```hcl
snapshots = {
  snap_web_01 = {
    server_ref  = "srv_web_01"
    description = "Pre-upgrade snapshot"
  }
}
```

## Inputs

| Name | Description | Required |
|------|-------------|----------|
| server_ref | Reference key to the server | Yes |
| description | Snapshot description | No |
| labels | Key-value label pairs | No |
