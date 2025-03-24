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
    for_each = try([var.settings.identity], [])
    content {
      type         = try(identity.value.type, null)
      identity_ids = try(identity.value.identity_ids, null)
    }
  }

  dynamic "site_config" {
    for_each = try([var.settings.site_config], [])
    content {
      use_32_bit_worker_process = try(site_config.value.use_32_bit_worker_process, null)
      # Add more site_config settings if needed later
    }
  }

  dynamic "connection_string" {
    for_each = try(var.settings.connection_string, [])
    content {
      name  = connection_string.value.name
      type  = connection_string.value.type
      value = connection_string.value.value
    }
  }
}
