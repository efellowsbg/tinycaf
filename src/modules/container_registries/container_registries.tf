resource "azurerm_container_registry" "main" {
  name                = var.settings.name
  resource_group_name = local.resource_group_name
  location            = local.location
  tags                = local.tags
  sku                 = var.settings.sku

  admin_enabled = try(var.settings.admin_enabled, false)

  dynamic "georeplications" {
    for_each = var.settings.georeplications

    content {
      location                = georeplications.value.name
      zone_redundancy_enabled = try(georeplications.value.zone_redundancy_enabled, false)
      tags                    = try(georeplications.value.tags, null)
    }
  }
}
