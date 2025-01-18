resource "azurerm_key_vault" "main" {
  for_each            = var.keyvaults
  name                = each.value.name
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


module "logged_in_user" {
  source = "./keyvault_access_policy"
  for_each = {
    for key, access_policy in var.access_policies : key => access_policy
    if key == "logged_in_user" && var.global_settings.object_id != null
  }

  keyvault_id = var.resources.keyvaults[each.key].id

  access_policy = each.value
  tenant_id     = var.global_settings.tenant_id
  object_id     = var.global_settings.object_id
  settings = var.settings
  resources = var.resources
  global_settings = var.global_settings
}
