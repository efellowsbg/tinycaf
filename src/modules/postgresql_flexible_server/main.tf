resource "azurerm_postgresql_flexible_server" "main" {
  name                              = var.settings.name
  resource_group_name               = local.resource_group_name
  location                          = local.location
  tags                              = local.tags
  delegated_subnet_id               = local.delegated_subnet_id
  private_dns_zone_id               = local.private_dns_zone_id
  administrator_login               = try(var.settings.administrator_login, null)
  administrator_password            = try(var.settings.administrator_password, null)
  backup_retention_days             = try(var.settings.backup_retention_days, null)
  geo_redundant_backup_enabled      = try(var.settings.geo_redundant_backup_enabled, null)
  create_mode                       = try(var.settings.create_mode, null)
  public_network_access_enabled     = try(var.settings.public_network_access_enabled, null)
  point_in_time_restore_time_in_utc = try(var.settings.point_in_time_restore_time_in_utc, null)
  replication_role                  = try(var.settings.replication_role, null)
  sku_name                          = try(var.settings.sku_name, null)
  source_server_id                  = try(var.settings.source_server_id, null)
  auto_grow_enabled                 = try(var.settings.auto_grow_enabled, null)
  storage_mb                        = try(var.settings.storage_mb, null)
  storage_tier                      = try(var.settings.storage_tier, null)
  version                           = try(var.settings.version, null)
  zone                              = try(var.settings.zone, null)

  dynamic "identity" {
    for_each = can(var.settings.identity) ? [1] : []
    content {
      type         = var.settings.identity.type
      identity_ids = try(local.identity_ids, null)
    }
  }

  dynamic "authentication" {
    for_each = can(var.settings.authentication) ? [1] : []
    content {
      active_directory_auth_enabled = try(var.settings.authentication.active_directory_auth_enabled, null)
      password_auth_enabled         = try(var.settings.authentication.password_auth_enabled, null)
      tenant_id                     = try(var.settings.authentication.tenant_id, null)
    }
  }

  dynamic "customer_managed_key" {
    for_each = can(var.settings.customer_managed_key) ? [1] : []
    content {
      key_vault_key_id                     = local.key_vault_key_id
      primary_user_assigned_identity_id    = local.primary_user_assigned_identity_id
      geo_backup_user_assigned_identity_id = local.geo_backup_user_assigned_identity_id
      geo_backup_key_vault_key_id          = local.geo_backup_key_vault_key_id
    }
  }

  dynamic "high_availability" {
    for_each = can(var.settings.high_availability) ? [1] : []
    content {
      mode                      = var.settings.high_availability.mode
      standby_availability_zone = try(var.settings.high_availability.standby_availability_zone, null)
    }
  }

  dynamic "maintenance_window" {
    for_each = can(var.settings.maintenance_window) ? [1] : []
    content {
      day_of_week  = try(var.settings.maintenance_window.day_of_week, null)
      start_hour   = try(var.settings.maintenance_window.start_hour, null)
      start_minute = try(var.settings.maintenance_window.start_minute, null)
    }
  }
}
