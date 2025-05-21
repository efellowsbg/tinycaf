resource "azurerm_linux_function_app" "linux_function_app" {
  name                = var.settings.name
  resource_group_name = local.resource_group_name
  location            = local.location

  storage_account_name       = try(var.resources.storage_accounts[var.settings.storage_account_ref].name, null)
  storage_account_access_key = try(var.resources.storage_accounts[var.settings.storage_account_ref].primary_access_key, null)
  public_network_access_enabled = try(var.settings.public_network_access_enabled, true)
  https_only = try(var.settings.https_only, true)
  service_plan_id            = var.resources.app_service_plans[var.settings.app_service_plan_ref].id
  app_settings = try(var.settings.app_settings, {})
  site_config {
    always_on = try(var.settings.site_config.always_on, false)
    linux_fx_version = try(var.settings.site_config.linux_fx_version, null)
    ftps_state = try(var.settings.site_config.ftps_state, null) 
    http2_enabled = try(var.settings.site_config.http2_enabled, null)
    api_definition_url = try(var.settings.site_config.api_definition_url, null)
    api_management_api_id = try(var.settings.site_config.api_management_api_id, null)
    app_command_line = try(var.settings.site_config.app_command_line, null)
    app_scale_limit = try(var.settings.site_config.app_scale_limit, null)
    application_insights_connection_string = try(var.settings.site_config.application_insights_connection_string, null)
    application_insights_key = try(var.settings.site_config.application_insights_key, null)
    dynamic "ip_restriction" {
    for_each = can(var.settings.site_config.ip_restriction) ? [1] : []

    content {
      ip_address = try(var.settings.site_config.ip_restriction.ip_address, null)
      action     = try(var.settings.site_config.ip_restriction.action, null)
      priority   = try(var.settings.site_config.ip_restriction.priority, null)
      name       = try(var.settings.site_config.ip_restriction.name, null)
      headers    = try(var.settings.site_config.ip_restriction.headers, null)
      virtual_network_subnet_id = try(local.subnet_id, null)
    }
  }
  }
  dynamic "identity" {
    for_each = can(var.settings.identity) ? [1] : []
    content {
      type         = var.settings.identity.type
      identity_ids = try(local.identity_ids, null)
    }
  }
}