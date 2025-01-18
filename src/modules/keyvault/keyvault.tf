resource "azurerm_key_vault" "main" {
  name                = var.settings.name
  resource_group_name = local.resource_group_name
  location            = local.location
  tags                = local.tags

  tenant_id = var.global_settings.tenant_id
  sku_name  = try(var.settings.sku_name, "standard")

  enabled_for_disk_encryption = try(var.settings.enabled_for_disk_encryption, null)
  soft_delete_retention_days  = try(var.settings.soft_delete_retention_days, null)
  purge_protection_enabled    = try(var.settings.purge_protection_enabled, null)
  enable_rbac_authorization   = try(var.settings.enable_rbac_authorization, false)

  network_acls {
    default_action             = try(var.settings.network_rules.default_action, "Deny")
    bypass                     = try(var.settings.network_rules.bypass, "AzureServices")
    ip_rules                   = try(var.settings.network_rules.allowed_ips, null)
    virtual_network_subnet_ids = local.subnet_ids
  }
}


module "access_policies" {
  source          = "./keyvault_access_policy"
  for_each        = try(var.settings.access_policies, {})
  settings        = var.settings
  global_settings = var.global_settings
  resources = {
    keyvaults          = azurerm_key_vault.main
    virtual_networks   = var.resources.virtual_networks
    managed_identities = var.resources.managed_identities
    resource_groups    = var.resources.resource_groups
    private_dns_zones  = var.resources.private_dns_zones
  }
}
