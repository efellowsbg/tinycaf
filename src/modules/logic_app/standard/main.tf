resource "azurerm_logic_app_standard" "main" {
  name                       = var.settings.name
  location                   = local.location
  resource_group_name        = local.resource_group_name
  app_service_plan_id        = local.app_service_plan_id
  storage_account_name       = local.storage_account_name
  storage_account_access_key = local.storage_account_primary_access_key

  app_settings               = try(var.settings.app_settings, null)
  use_extension_bundle       = try(var.settings.use_extension_bundle, null)
  bundle_version             = try(var.settings.bundle_version, null)
  client_affinity_enabled    = try(var.settings.client_affinity_enabled, null)
  client_certificate_mode    = try(var.settings.client_certificate_mode, null)
  enabled                    = try(var.settings.enabled, null)
  https_only                 = try(var.settings.https_only, null)
  public_network_access      = try(var.settings.public_network_access, null)
  storage_account_share_name = try(var.settings.storage_account_share_name, null)
  version                    = try(var.settings.version, null)
  virtual_network_subnet_id  = try(var.settings.virtual_network_subnet_id, null)
  tags                       = try(var.settings.tags, null)


  dynamic "identity" {
    for_each = can(var.settings.identity) ? [1] : []

    content {
      type         = try(var.settings.identity.type, null)
      identity_ids = try(local.identity_ids, null)
    }
  }

  dynamic "site_config" {
    for_each = can(var.settings.site_config) ? [1] : []
    content {
      always_on                        = try(var.settings.site_config.always_on, null)
      app_scale_limit                  = try(var.settings.site_config.app_scale_limit, null)
      auto_swap_slot_name              = try(var.settings.site_config.auto_swap_slot_name, null)
      dotnet_framework_version         = try(var.settings.site_config.dotnet_framework_version, null)
      elastic_instance_minimum         = try(var.settings.site_config.elastic_instance_minimum, null)
      ftps_state                       = try(var.settings.site_config.ftps_state, null)
      health_check_path                = try(var.settings.site_config.health_check_path, null)
      http2_enabled                    = try(var.settings.site_config.http2_enabled, null)
      ip_restriction                   = try(var.settings.site_config.ip_restriction, null)
      scm_ip_restriction               = try(var.settings.site_config.scm_ip_restriction, null)
      scm_use_main_ip_restriction      = try(var.settings.site_config.scm_use_main_ip_restriction, null)
      scm_min_tls_version              = try(var.settings.site_config.scm_min_tls_version, null)
      scm_type                         = try(var.settings.site_config.scm_type, null)
      linux_fx_version                 = try(var.settings.site_config.linux_fx_version, null)
      min_tls_version                  = try(var.settings.site_config.min_tls_version, null)
      pre_warmed_instance_count        = try(var.settings.site_config.pre_warmed_instance_count, null)
      runtime_scale_monitoring_enabled = try(var.settings.site_config.runtime_scale_monitoring_enabled, null)
      use_32_bit_worker_process        = try(var.settings.site_config.use_32_bit_worker_process, null)
      vnet_route_all_enabled           = try(var.settings.site_config.vnet_route_all_enabled, null)
      websockets_enabled               = try(var.settings.site_config.websockets_enabled, null)
      dynamic "cors" {
        for_each = can(var.settings.site_config.cors) ? [1] : []
        content {
          allowed_origins     = try(var.settings.site_config.cors.allowed_origins, [])
          support_credentials = try(var.settings.site_config.cors.support_credentials, null)
        }
      }
    }
  }

  dynamic "connection_string" {
    for_each = can(var.settings.connection_string) ? [1] : []
    content {
      name  = try(var.settings.connection_string.name, null)
      type  = try(var.settings.connection_string.type, null)
      value = try(var.settings.connection_string.value, null)
    }
  }
}
