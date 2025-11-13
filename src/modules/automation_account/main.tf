resource "azurerm_automation_account" "main" {
  name                          = var.settings.name
  resource_group_name           = try(local.resource_group_name, var.settings.resource_group_name)
  location                      = try(local.location, var.settings.location)
  sku_name                      = try(var.settings.sku_name, "Free")
  local_authentication_enabled  = try(var.settings.local_authentication_enabled, null)
  public_network_access_enabled = try(var.settings.public_network_access_enabled, null)
  tags                          = local.tags

  dynamic "identity" {
    for_each = can(var.settings.identity) ? [1] : []
    content {
      type = var.settings.identity.type
      identity_ids = try(
        [
          for mi_ref in var.settings.identity.mi_refs :
          var.resources[
            try(var.settings.identity.mi_lz_key, var.client_config.landingzone_key)
          ].managed_identities[mi_ref].id
        ],
        try(var.settings.identity.identity_ids, null)
      )
    }
  }
  dynamic "encryption" {
    for_each = can(var.settings.encryption) ? [1] : []
    content {
      key_vault_key_id = try(
        var.resources[
          try(var.settings.encryption.keys_lz_key, var.client_config.landingzone_key)
        ].key_vault_keys[var.settings.encryption.key_ref].id,
        var.settings.encryption.key_vault_key_id
      )
      user_assigned_identity_id = try(
        var.resources[
          try(var.settings.encryption.mi_lz_key, var.client_config.landingzone_key)
        ].managed_identities[var.settings.encryption.mi_ref].id,
        try(var.settings.encryption.user_assigned_identity_id, null)
      )
    }
  }
}
