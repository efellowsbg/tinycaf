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
}

locals {
effective_key_permissions = (
    var.access_policies.key_permissions == "All" ?
    local.all_key_permissions :
    try(var.access_policies.key_permissions, [])
  )
effective_secret_permissions = (
    var.access_policies.secret_permissions == "All" ?
    local.all_secret_permissions :
    try(var.access_policies.secret_permissions, [])
  )
}


locals {
  debug_settings = var.settings
  has_logged_in_key = contains(keys(var.settings), "managed_identity")
}
