# Storage Box Module

Manages an hcloud_storage_box resource.

## Usage

```hcl
storage_boxes = {
  sb_backup = {
    name             = "backup-storage"
    location         = "fsn1"
    storage_box_type = "storagebox-10"
    password         = "secure-password"
    access_settings = {
      ssh_enabled = true
    }
  }
}
```

## Inputs

| Name | Description | Required |
|------|-------------|----------|
| name | Storage box name | Yes |
| location | Location | Yes |
| storage_box_type | Storage box type | Yes |
| password | Password (sensitive) | Yes |
| labels | Key-value label pairs | No |
| delete_protection | Enable delete protection | No |
| ssh_keys | Set of SSH public keys | No |
| access_settings | Access settings block | No |
| snapshot_plan | Snapshot plan configuration | No |
