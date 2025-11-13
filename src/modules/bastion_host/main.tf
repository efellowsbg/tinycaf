resource "azurerm_bastion_host" "main" {
  name                      = var.settings.name
  resource_group_name       = try(local.resource_group_name, var.settings.resource_group_name)
  location                  = try(local.location, var.settings.location)
  copy_paste_enabled        = try(var.settings.copy_paste_enabled, null)
  file_copy_enabled         = try(var.settings.file_copy_enabled, null)
  sku                       = try(var.settings.sku, null)
  ip_connect_enabled        = try(var.settings.ip_connect_enabled, null)
  kerberos_enabled          = try(var.settings.kerberos_enabled, null)
  scale_units               = try(var.settings.scale_units, null)
  shareable_link_enabled    = try(var.settings.shareable_link_enabled, null)
  tunneling_enabled         = try(var.settings.tunneling_enabled, null)
  session_recording_enabled = try(var.settings.session_recording_enabled, null)
  zones                     = try(var.settings.zones, null)
  virtual_network_id        = local.virtual_network_id
  tags                      = local.tags

  dynamic "ip_configuration" {
    for_each = can(var.settings.ip_configuration) ? [1] : []
    content {
      name = try(var.settings.ip_configuration.name, "ip-config-${var.settings.name}")
      subnet_id = try(
        var.resources[
          try(var.settings.ip_configuration.sub_lz_key, var.client_config.landingzone_key)
          ].virtual_networks[
          split("/", var.settings.ip_configuration.subnet_ref)[0]
          ].subnets[
          split("/", var.settings.ip_configuration.subnet_ref)[1]
        ].id,
        var.settings.ip_configuration.subnet_id
      )
      public_ip_address_id = try(
        var.resources[
          try(var.settings.ip_configuration.pip_lz_key, var.client_config.landingzone_key)
        ].public_ips[var.settings.ip_configuration.public_ip_ref].id,
        try(var.settings.ip_configuration.public_ip_address_id, null)
      )
    }
  }
}
