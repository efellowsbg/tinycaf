resource "azurerm_key_vault" "main" {
  name                        = var.settings.name
  resource_group_name         = local.resource_group_name
  location                    = local.location
  enabled_for_disk_encryption = try(var.settings.enabled_for_disk_encryption, true)
  tenant_id                   = local.tenant_id
  soft_delete_retention_days  = try(var.settings.soft_delete_retention_days, 7)
  purge_protection_enabled    = try(var.settings.purge_protection_enabled, false)
  sku_name                    = try(var.settings.sku_name, "standard")
  enable_rbac_authorization   = try(var.settings.enable_rbac_authorization, null)
  network_acls {
    default_action             = try(var.settings.network.default_action, null)
    bypass                     = try(var.settings.network.bypass, "AzureServices")
    ip_rules                   = try(var.settings.network.allowed_ips, null)
    virtual_network_subnet_ids = local.subnet_ids
  }
}
