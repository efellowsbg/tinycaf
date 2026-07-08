# Storage Box Snapshot Module

Manages an hcloud_storage_box_snapshot resource.

## Usage

```hcl
storage_box_snapshots = {
  sbs_backup = {
    storage_box_ref = "sb_backup"
    description     = "Weekly snapshot"
  }
}
```

## Inputs

| Name | Description | Required |
|------|-------------|----------|
| storage_box_ref | Reference key to the storage box | Yes |
| description | Snapshot description | No |
| labels | Key-value label pairs | No |
