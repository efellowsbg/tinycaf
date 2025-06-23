resource "azurerm_container_registry" "main" {
  name                = var.settings.name
  resource_group_name = local.resource_group_name
  location            = local.location
  tags                = local.tags
  sku                 = var.settings.sku

  public_network_access_enabled = try(var.settings.public_network_access_enabled, false)
  admin_enabled                 = try(var.settings.admin_enabled, false)

  dynamic "georeplications" {
    for_each = try(length(var.settings.georeplications) > 0 ? [1] : [], [])

    content {
      location                 = try(georeplications.value.location, null)
      zone_redundancy_enabled = try(georeplications.value.zone_redundancy_enabled, false)
      tags                    = try(georeplications.value.tags, null)
    }
  }

  dynamic "identity" {
    for_each = try(length(var.settings.identity) > 0 ? [1] : [], [])

    content {
      type         = var.settings.identity.type
      identity_ids = try(local.identity_ids, null)
    }
  }

  dynamic "encryption" {
    for_each = try(length(var.settings.encryption) > 0 ? [1] : [], [])

    content {
      key_vault_key_id = try(
        var.resources[
          try(var.settings.encryption.key_vault_key_lz_key, var.client_config.landingzone_key)
        ].key_vault_keys[var.settings.encryption.key_vault_key_ref].id,
        null
      )

      identity_client_id = try(
        var.resources[
          try(var.settings.encryption.identity_lz_key, var.client_config.landingzone_key)
        ].managed_identities[var.settings.encryption.identity_ref].id,
        null
      )
    }
  }

  dynamic "network_rule_set" {
    for_each = try(length(var.settings.network_rule_set) > 0 ? [1] : [], [])

    content {
      default_action = try(var.settings.network_rule_set[0].default_action, "Allow")

      dynamic "ip_rule" {
        for_each = try(var.settings.network_rule_set[0].ip_rule, [])

        content {
          action   = try(ip_rule.value.action, "Allow")
          ip_range = ip_rule.value.ip_range
        }
      }
    }
  }
}
