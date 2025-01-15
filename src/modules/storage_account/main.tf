resource "azurerm_storage_account" "main" {
  name                     = var.settings.name
  resource_group_name      = local.resource_group_name
  location                 = local.location
  account_tier             = var.settings.account_tier
  account_replication_type = var.settings.account_replication_type

  network_rules {
    default_action             = try(var.settings.default_action, "Deny")
    ip_rules                   = try(var.settings.ip_rules, null)
    virtual_network_subnet_ids = [for id in local.subnet_id : tostring(id)]
  }

  tags = try(local.tags, null)
}