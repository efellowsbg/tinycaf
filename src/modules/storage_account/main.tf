resource "azurerm_storage_account" "main" {
  name                     = var.settings.name
  resource_group_name      = local.resource_group_name
  location                 = local.location
  account_tier             = var.settings.account_tier
  account_replication_type = var.settings.account_replication_type

  network_rules {
    default_action             = try(var.settings.default_action, "deny")
    ip_rules                   = try(var.settings.ip_rules, null)
    virtual_network_subnet_ids = var.settings.network_rules.virtual_network_subnet_ids
  }

  # network_rules = var.settings.network_rules

  tags = try(local.tags, null)
}