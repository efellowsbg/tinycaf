resource "azurerm_logic_app_standard" "example" {
  name                       = var.settings.name
  location                   = local.location
  resource_group_name        = local.resource_group_name
  app_service_plan_id        = local.app_service_plan_id
  storage_account_name       = local.storage_account_name
  storage_account_access_key = local.storage_account_primary_access_key
  app_settings = try(var.settings.app_settings, null)

  # dynamic "app_settings" {
  #   for_each = can(var.settings.app_settings) ? [1] : []

  #   content {
  #   }
  # }

  # app_settings = {
  #   "FUNCTIONS_WORKER_RUNTIME"     = "node"
  #   "WEBSITE_NODE_DEFAULT_VERSION" = "~18"
  # }
}