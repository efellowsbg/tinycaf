resource "azurerm_container_registry" "main" {
  name                = var.settings.name
  resource_group_name = local.resource_group_name
  location            = local.location
  tags                = local.tags
  sku                 = var.settings.sku

  public_network_access_enabled = try(var.settings.public_network_access_enabled, false)
  admin_enabled                 = try(var.settings.admin_enabled, false)

  dynamic "georeplications" {
    for_each = try(var.settings.georeplications, null)

    content {
      location                = try(georeplications.value.location, null)
      zone_redundancy_enabled = try(georeplications.value.zone_redundancy_enabled, false)
      tags                    = try(georeplications.value.tags, null)
    }
  }
}
