resource "azurerm_mssql_database" "main" {
  for_each = try(var.settings.databases, {})

  name                                                       = each.value.name
  server_id                                                  = azurerm_mssql_server.main.id
  auto_pause_delay_in_minutes                                = try(each.value.auto_pause_delay_in_minutes, null)
  create_mode                                                = try(each.value.create_mode, null)
  collation                                                  = try(each.value.collation, null)
  enclave_type                                               = try(each.value.enclave_type, null)
  geo_backup_enabled                                         = try(each.value.geo_backup_enabled, null)
  maintenance_configuration_name                             = try(each.value.maintenance_configuration_name, null)
  ledger_enabled                                             = try(each.value.ledger_enabled, null)
  license_type                                               = try(each.value.license_type, null)
  max_size_gb                                                = try(each.value.max_size_gb, null)
  min_capacity                                               = try(each.value.min_capacity, null)
  restore_point_in_time                                      = try(each.value.restore_point_in_time, null)
  recovery_point_id                                          = try(each.value.recovery_point_id, null)
  read_replica_count                                         = try(each.value.read_replica_count, null)
  read_scale                                                 = try(each.value.read_scale, null)
  sample_name                                                = try(each.value.sample_name, null)
  sku_name                                                   = try(each.value.sku_name, null)
  storage_account_type                                       = try(each.value.storage_account_type, null)
  transparent_data_encryption_enabled                        = try(each.value.transparent_data_encryption_enabled, null)
  transparent_data_encryption_key_automatic_rotation_enabled = try(each.value.transparent_data_encryption_key_automatic_rotation_enabled, null)
  zone_redundant                                             = try(each.value.zone_redundant, null)
  secondary_type                                             = try(each.value.secondary_type, null)
  transparent_data_encryption_key_vault_key_id               = try(each.value.transparent_data_encryption_key_vault_key_id, null)
  creation_source_database_id                                = try(each.value.creation_source_database_id, null)
  restore_dropped_database_id                                = try(each.value.restore_dropped_database_id, null)
  restore_long_term_retention_backup_id                      = try(each.value.restore_long_term_retention_backup_id, null)
  recover_database_id                                        = try(each.value.recover_database_id, null)
  elastic_pool_id                                            = try(each.value.elastic_pool_id, null)
  tags                                                       = local.tags

  dynamic "import" {
    for_each = can(each.value.identity) ? [1] : []

    content {
      storage_uri                  = each.value.identity.storage_uri
      storage_key                  = each.value.identity.storage_key
      storage_key_type             = each.value.identity.storage_key_type
      administrator_login          = each.value.identity.administrator_login
      administrator_login_password = each.value.identity.administrator_login_password
      authentication_type          = each.value.identity.authentication_type
      storage_account_id           = try(each.value.identity.storage_account_id, null)
    }
  }

  dynamic "threat_detection_policy" {
    for_each = can(each.value.threat_detection_policy) ? [1] : []

    content {
      state                      = try(each.value.threat_detection_policy.state, null)
      disabled_alerts            = try(each.value.threat_detection_policy.disabled_alerts, null)
      email_account_admins       = try(each.value.threat_detection_policy.email_account_admins, null)
      email_addresses            = try(each.value.threat_detection_policy.email_addresses, null)
      retention_days             = try(each.value.threat_detection_policy.retention_days, null)
      storage_account_access_key = try(each.value.threat_detection_policy.storage_account_access_key, null)
      storage_endpoint           = try(each.value.threat_detection_policy.storage_endpoint, null)
    }
  }

  dynamic "long_term_retention_policy" {
    for_each = can(each.value.long_term_retention_policy) ? [1] : []

    content {
      weekly_retention          = try(each.value.long_term_retention_policy.weekly_retention, null)
      monthly_retention         = try(each.value.long_term_retention_policy.monthly_retention, null)
      yearly_retention          = try(each.value.long_term_retention_policy.yearly_retention, null)
      week_of_year              = try(each.value.long_term_retention_policy.week_of_year, null)
      immutable_backups_enabled = try(each.value.long_term_retention_policy.immutable_backups_enabled, null)
    }
  }

  dynamic "short_term_retention_policy" {
    for_each = can(each.value.short_term_retention_policy) ? [1] : []

    content {
      retention_days           = each.value.short_term_retention_policy.retention_days
      backup_interval_in_hours = try(each.value.short_term_retention_policy.backup_interval_in_hours, null)
    }
  }

  dynamic "identity" {
    for_each = can(each.value.identity) ? [1] : []

    content {
      type         = each.value.identity.type
      identity_ids = try(each.value.identity.identity_ids, null)
    }
  }
}
