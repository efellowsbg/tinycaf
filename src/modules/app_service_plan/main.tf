resource "azurerm_service_plan" "main" {
  name                = var.settings.name
  resource_group_name = local.resource_group_name
  location            = local.location
  os_type             = var.settings.os_type
  sku_name            = var.settings.sku_name
  app_service_environment_id = try(var.settings.app_service_environment_id, null)
  maximum_elastic_worker_count = try(var.settings.maximum_elastic_worker_count, null)
  per_site_scaling_enabled = try(var.settings.per_site_scaling_enabled, null)
  zone_balancing_enabled = try(var.settings.zone_balancing_enabled, null)
  tags = local.tags
}
