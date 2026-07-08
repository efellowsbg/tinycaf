# Storage Box Subaccount Module

Manages an hcloud_storage_box_subaccount resource.

## Usage

```hcl
storage_box_subaccounts = {
  sbsa_app = {
    storage_box_ref = "sb_backup"
    home_directory  = "/app-backups"
    password        = "secure-password"
    name            = "app-backup-user"
    access_settings = {
      ssh_enabled = true
      readonly    = false
    }
  }
}
```

## Inputs

| Name | Description | Required |
|------|-------------|----------|
| storage_box_ref | Reference key to the storage box | Yes |
| home_directory | Home directory path | Yes |
| password | Password (sensitive) | Yes |
| name | Subaccount name | No |
| description | Description | No |
| labels | Key-value label pairs | No |
| access_settings | Access settings block | No |
