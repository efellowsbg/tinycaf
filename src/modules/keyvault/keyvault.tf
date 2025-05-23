resource "azurerm_key_vault" "main" {
  name                = var.settings.name
  resource_group_name = local.resource_group_name
  location            = local.location
  tags                = local.tags
  tenant_id           = var.global_settings.tenant_id

  sku_name                    = try(var.settings.sku_name, "standard")
  enabled_for_disk_encryption = try(var.settings.enabled_for_disk_encryption, null)
  soft_delete_retention_days  = try(var.settings.soft_delete_retention_days, null)
  purge_protection_enabled    = try(var.settings.purge_protection_enabled, null)
  enable_rbac_authorization   = try(var.settings.enable_rbac_authorization, false)

  public_network_access_enabled = try(var.settings.public_network_access_enabled, false)

  dynamic "network_acls" {
    for_each = can(var.settings.network_rules) ? [1] : []

    content {
      bypass                     = try(var.settings.network_rules.bypass, "AzureServices")
      default_action             = try(var.settings.network_rules.default_action, "Deny")
      ip_rules                   = try(var.settings.network_rules.allowed_ips, null)
      virtual_network_subnet_ids = try(local.subnet_ids, null)
    }
  }
}