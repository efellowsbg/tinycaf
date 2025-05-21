resource "azurerm_postgresql_server" "postgres" {
  name                = var.settings.name
  location            = local.location
  resource_group_name = local.resource_group_name
  tags                = local.tags

  administrator_login          = var.settings.keyvault_ref != null ? "postgreadmin" : null
  administrator_login_password =  var.settings.keyvault_ref != null ? random_password.admin[0].result : null

  sku_name   = try(var.settings.sku_name, "GP_Gen5_4")
  version    = try(var.settings.version, "11")
  storage_mb = try(var.settings.storage_mb, 5120)

  backup_retention_days        = try(var.settings.backup_retention_days, 7)
  geo_redundant_backup_enabled = try(var.settings.geo_redundant_backup_enabled, true)
  auto_grow_enabled            = try(var.settings.auto_grow_enabled, true)

  public_network_access_enabled     = try(var.settings.public_network_access_enabled, false)
  ssl_enforcement_enabled           = try(var.settings.ssl_enforcement_enabled, true)
  ssl_minimal_tls_version_enforced  = try(var.settings.ssl_minimal_tls_version_enforced, "TLS1_2")
  create_mode                       = try(var.settings.create_mode, "Default")
  creation_source_server_id         = try(var.settings.creation_source_server_id, null)
  infrastructure_encryption_enabled = try(var.settings.infrastructure_encryption_enabled, false)

  dynamic "identity" {
    for_each = var.settings.use_system_identity == true ? [1] : []
    content {
      type = "SystemAssigned"
    }
  }
  dynamic "threat_detection_policy" {
    for_each = try([var.settings.threat_detection_policy], [])

    content {
      enabled                    = try(threat_detection_policy.value.enabled, null)
      disabled_alerts            = try(threat_detection_policy.value.disabled_alerts, null)
      email_account_admins       = try(threat_detection_policy.value.email_account_admins, null)
      email_addresses            = try(threat_detection_policy.value.email_addresses, null)
      retention_days             = try(threat_detection_policy.value.retention_days, null)
      storage_account_access_key = try(threat_detection_policy.value.storage_account_access_key, null)
      storage_endpoint           = try(threat_detection_policy.value.storage_endpoint, null)
    }
  }
}

resource "random_password" "admin" {
  count = try(length(trimspace(var.settings.keyvault_ref)) > 0, false) ? 1 : 0
  length           = 15
  min_upper        = 2
  min_lower        = 2
  min_special      = 2
  numeric          = true
  special          = true
  override_special = "!@#$%&"
}

resource "azurerm_key_vault_secret" "admin_password" {
  count = try(length(trimspace(var.settings.keyvault_ref)) > 0, false) ? 1 : 0
  name         = "${var.settings.name}-psqladmin-password"
  value        = random_password.admin[0].result
  key_vault_id = local.key_vault_id
}
