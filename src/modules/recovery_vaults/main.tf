resource "azurerm_recovery_services_vault" "asr" {
  name                = var.settings.name
  location            = local.location
  resource_group_name = local.resource_group_name
  sku                 = "Standard"
  soft_delete_enabled = try(var.settings.soft_delete_enabled, true)
  storage_mode_type   = try(var.settings.storage_mode_type, "GeoRedundant")
  tags                = local.tags

  dynamic "identity" {
    for_each = can(var.settings.identity) ? [1] : []

    content {
      type         = var.settings.identity.type
      identity_ids = try(local.identity_ids, null)
    }
  }

  dynamic "encryption" {
    for_each = can(var.settings.encryption) ? [1] : []

    content {
      use_system_assigned_identity      = try(var.settings.encryption.use_system_assigned_identity, var.settings.identity.type == "SystemAssigned" || var.settings.identity.type == "SystemAssigned, UserAssigned")
      infrastructure_encryption_enabled = try(var.settings.encryption.infrastructure_encryption_enabled, false)

      key_id                    = can(var.settings.encryption.key_id) ? var.settings.encryption.key_id : local.encryption_key
      user_assigned_identity_id = can(var.settings.encryption.managed_identity_id) ? var.settings.encryption.managed_identity_id : local.encryption_identity
    }
  }
}