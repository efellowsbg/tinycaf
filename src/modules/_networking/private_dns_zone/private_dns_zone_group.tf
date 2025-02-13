resource "azurerm_private_dns_zone" "main" {
  name                = try(local.zone_names[var.settings.resource_kind], var.settings.name)
  resource_group_name = local.resource_group_name
  tags                = try(local.tags, null)
}
