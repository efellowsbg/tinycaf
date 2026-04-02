# Volume Module

Manages an hcloud_volume resource.

## Usage

```hcl
volumes = {
  vol_data = {
    name     = "vol-data-01"
    size     = 50
    location = "fsn1"
    format   = "ext4"
  }
}
```

## Inputs

| Name | Description | Required |
|------|-------------|----------|
| name | Volume name | Yes |
| size | Volume size in GB | Yes |
| location | Location (conflicts with server_ref) | No |
| server_ref | Server reference key (conflicts with location) | No |
| automount | Auto-mount on server (requires server_ref) | No |
| format | Filesystem format: ext4 or xfs | No |
| labels | Key-value label pairs | No |
| delete_protection | Enable delete protection | No |
