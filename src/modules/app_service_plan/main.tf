resource "azurerm_app_service_plan" "main" {
  name                = var.settings.name
  resource_group_name = local.resource_group_name
  location            = local.location

  kind = try(var.settings.kind, "Linux")
  maximum_elastic_worker_count = try(var.settings.maximum_elastic_worker_count, null)
  app_service_environment_id  = try(var.settings.app_service_environment_id, null)
  reserved = try(var.settings.reserved, null)
  is_xenon = try(var.settings.is_xenon, null)
  zone_redundant  = try(var.settings.zone_redundant, null)


  sku {
    tier = var.settings.sku.tier
    size = var.settings.sku.size
  }
}