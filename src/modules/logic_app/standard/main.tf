resource "azurerm_logic_app_standard" "example" {
  name                       = var.settings.name
  location                   = local.location
  resource_group_name        = local.resource_group_name
  app_service_plan_id        = local.app_service_plan_id
  storage_account_name       = local.storage_account_name
  storage_account_access_key = local.storage_account_primary_access_key

  app_settings                             = try(var.settings.app_settings, null)
  use_extension_bundle                     = try(var.settings.use_extension_bundle, null)
  bundle_version                           = try(var.settings.bundle_version, null)
  client_affinity_enabled                  = try(var.settings.client_affinity_enabled, null)
  client_certificate_mode                  = try(var.settings.client_certificate_mode, null)
  enabled                                  = try(var.settings.enabled, null)
  https_only                               = try(var.settings.https_only, null)
  public_network_access                    = try(var.settings.public_network_access, null)
  storage_account_share_name               = try(var.settings.storage_account_share_name, null)
  version                                  = try(var.settings.version, null)
  virtual_network_subnet_id                = try(var.settings.virtual_network_subnet_id, null)
  tags                                     = try(var.settings.tags, null)

  
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
        always_on                       = try(site_config.value.always_on, null)
        app_scale_limit                = try(site_config.value.app_scale_limit, null)
        auto_swap_slot_name            = try(site_config.value.auto_swap_slot_name, null)
        dotnet_framework_version       = try(site_config.value.dotnet_framework_version, null)
        elastic_instance_minimum       = try(site_config.value.elastic_instance_minimum, null)
        ftps_state                     = try(site_config.value.ftps_state, null)
        health_check_path              = try(site_config.value.health_check_path, null)
        http2_enabled                  = try(site_config.value.http2_enabled, null)
        ip_restriction                 = try(site_config.value.ip_restriction, null)
        scm_ip_restriction             = try(site_config.value.scm_ip_restriction, null)
        scm_use_main_ip_restriction    = try(site_config.value.scm_use_main_ip_restriction, null)
        scm_min_tls_version            = try(site_config.value.scm_min_tls_version, null)
        scm_type                       = try(site_config.value.scm_type, null)
        linux_fx_version               = try(site_config.value.linux_fx_version, null)
        min_tls_version                = try(site_config.value.min_tls_version, null)
        pre_warmed_instance_count      = try(site_config.value.pre_warmed_instance_count, null)
        runtime_scale_monitoring_enabled = try(site_config.value.runtime_scale_monitoring_enabled, null)
        use_32_bit_worker_process      = try(site_config.value.use_32_bit_worker_process, null)
        vnet_route_all_enabled         = try(site_config.value.vnet_route_all_enabled, null)
        websockets_enabled             = try(site_config.value.websockets_enabled, null)
        dynamic "cors" {
          for_each = can(var.settings.site_config.cors) ? [1] : []
          content {
            allowed_origins = try(cors.value.allowed_origins, null)
            support_credentials = try(cors.value.support_credentials, null)
          }
        }
    }
  }

  dynamic "connection_string" {
    for_each = can(var.settings.connection_string) ? [1] : []
    content {
      name = try(connection_string.value.name, null)
      type = try(connection_string.value.type, null)
      value = try(connection_string.value.value, null)
    }
  }
}

