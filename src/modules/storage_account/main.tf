resource "azurerm_storage_account" "main" {
  name                     = var.settings.name
  resource_group_name      = local.resource_group_name
  location                 = local.location
  account_tier             = var.settings.account_tier
  account_replication_type = var.settings.account_replication_type

  network_rules {
    default_action             = try(var.settings.default_action, "Deny")
    ip_rules                   = try(var.settings.ip_rules, null)
    virtual_network_subnet_ids = local.subnet_ids
    # virtual_network_subnet_ids = try(var.settings.network, null) == null ? null : [
    #     for key, value in var.settings.network : can(value.subnet_id) ? value.subnet_id : var.resources.virtual_networks[value.vnet_ref].subnets[value.subnet_ref].id
    #   ]
  }

  tags = try(local.tags, null)
}