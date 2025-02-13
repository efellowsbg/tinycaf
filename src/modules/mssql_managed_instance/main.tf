resource "azurerm_mssql_managed_instance" "main" {
  name                = var.settings.name
  resource_group_name = local.resource_group_name
  location            = local.location
  subnet_id           = local.subnet_id
  tags                = local.tags

  license_type       = try(var.settings.license_type, "BasePrice")
  sku_name           = try(var.settings.sku_name, "GP_Gen5")
  storage_size_in_gb = try(var.settings.storage_size_in_gb, "32")
  vcores             = try(var.settings.vcores, "4")

  administrator_login            = try(var.settings.administrator_login, null)
  administrator_login_password   = try(var.settings.administrator_login_password, null)
  collation                      = try(var.settings.collation, null)
  dns_zone_partner_id            = try(var.settings.dns_zone_partner_id, null)
  maintenance_configuration_name = try(var.settings.maintenance_configuration_name, null)
  minimum_tls_version            = try(var.settings.minimum_tls_version, null)
  proxy_override                 = try(var.settings.proxy_override, null)
  public_data_endpoint_enabled   = try(var.settings.public_data_endpoint_enabled, null)
  service_principal_type         = try(var.settings.service_principal_type, null)
  storage_account_type           = try(var.settings.storage_account_type, null)
  zone_redundant_enabled         = try(var.settings.zone_redundant_enabled, null)
  timezone_id                    = try(var.settings.timezone_id, null)

  # dynamic "azure_active_directory_administrator" {
  #   for_each = can(var.settings.azure_active_directory_administrator) ? [1] : []

  #   content {
  #     login_username                      = var.settings.azure_active_directory_administrator.login_username
  #     object_id                           = var.settings.azure_active_directory_administrator.object_id
  #     principal_type                      = var.settings.azure_active_directory_administrator.principal_type
  #     azuread_authentication_only_enabled = try(var.settings.azure_active_directory_administrator.azuread_authentication_only_enabled, null)
  #     tenant_id                           = try(var.settings.azure_active_directory_administrator.tenant_id, null)
  #   }
  # }

  dynamic "identity" {
    for_each = can(var.settings.identity) ? [1] : []

    content {
      type         = try(var.settings.identity.type, null)
      identity_ids = try(local.identity_ids, null)
    }
  }

  dynamic "timeouts" {
    for_each = can(var.settings.timeouts) ? [1] : []

    content {
      create = try(var.settings.timeouts.create, null)
      update = try(var.settings.timeouts.update, null)
      read   = try(var.settings.timeouts.read, null)
      delete = try(var.settings.timeouts.delete, null)
    }
  }
}
