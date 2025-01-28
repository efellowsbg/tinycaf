resource "azurerm_log_analytics_workspace" "main" {
  name                = var.settings.name
  resource_group_name = local.resource_group_name
  location            = local.location
  sku                 = var.settings.sku
  retention_in_days   = var.settings.retention_in_days
}
