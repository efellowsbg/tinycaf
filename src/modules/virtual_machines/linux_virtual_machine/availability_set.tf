resource "azurerm_availability_set" "main" {
  count = try(var.settings.availability_set, null) == null ? 0 : 1
  name = try(var.settings.availability_set.name)
  location = local.location
  resource_group_name = local.resource_group_name
}