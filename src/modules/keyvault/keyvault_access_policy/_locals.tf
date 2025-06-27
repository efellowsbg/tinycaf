locals {
  all_secret_permissions = [
    "Backup",
    "Delete",
    "Get",
    "List",
    "Purge",
    "Recover",
    "Restore",
    "Set",
  ]

  all_key_permissions = [
    "Backup",
    "Create",
    "Decrypt",
    "Delete",
    "Encrypt",
    "Get",
    "Import",
    "List",
    "Purge",
    "Recover",
    "Restore",
    "Sign",
    "UnwrapKey",
    "Update",
    "Verify",
    "WrapKey",
    "Release",
    "Rotate",
    "GetRotationPolicy",
    "SetRotationPolicy",
  ]
  all_certificate_permissions = [
    "Backup", "Create", "Delete", "DeleteIssuers", "Get", "GetIssuers", "Import",
    "List", "ManageContacts", "ManageIssuers", "Purge", "Recover", "Restore",
    "SetIssuers", "Update",
  ]

  debug_settings    = var.settings
  has_logged_in_key = contains(keys(var.settings), "managed_identity")
}
