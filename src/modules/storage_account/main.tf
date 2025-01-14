resource "azurerm_storage_account" "main" {
  name                     = var.settings.name
  resource_group_name      = local.resource_group_name
  location                 = local.location
  account_tier             = var.settings.account_tier
  account_replication_type = var.settings.account_replication_type

  tags = try(local.tags, null)
}