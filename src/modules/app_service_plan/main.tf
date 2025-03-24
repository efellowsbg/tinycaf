resource "azurerm_app_service_plan" "main" {
  name                = var.settings.name
  resource_group_name = local.resource_group_name
  location            = local.location

  kind = try(var.settings.kind, "Linux")

  sku {
    tier = var.settings.sku.tier
    size = var.settings.sku.size
  }
}