resource "azurerm_mssql_database" "main" {
  name                                                       = try(var.databases.name, var.database_name)
  server_id                                                  = var.mssql_server_id
  auto_pause_delay_in_minutes                                = try(var.databases.auto_pause_delay_in_minutes, null)
  create_mode                                                = try(var.databases.create_mode, null)
  collation                                                  = try(var.databases.collation, null)
  enclave_type                                               = try(var.databases.enclave_type, null)
  geo_backup_enabled                                         = try(var.databases.geo_backup_enabled, null)
  maintenance_configuration_name                             = try(var.databases.maintenance_configuration_name, null)
  ledger_enabled                                             = try(var.databases.ledger_enabled, null)
  license_type                                               = try(var.databases.license_type, null)
  max_size_gb                                                = try(var.databases.max_size_gb, null)
  min_capacity                                               = try(var.databases.min_capacity, null)
  restore_point_in_time                                      = try(var.databases.restore_point_in_time, null)
  recovery_point_id                                          = try(var.databases.recovery_point_id, null)
  read_replica_count                                         = try(var.databases.read_replica_count, null)
  read_scale                                                 = try(var.databases.read_scale, null)
  sample_name                                                = try(var.databases.sample_name, null)
  sku_name                                                   = try(var.databases.sku_name, null)
  storage_account_type                                       = try(var.databases.storage_account_type, null)
  transparent_data_encryption_enabled                        = try(var.databases.transparent_data_encryption_enabled, null)
  transparent_data_encryption_key_automatic_rotation_enabled = try(var.databases.transparent_data_encryption_key_automatic_rotation_enabled, null)
  zone_redundant                                             = try(var.databases.zone_redundant, null)
  secondary_type                                             = try(var.databases.secondary_type, null)
  transparent_data_encryption_key_vault_key_id               = try(var.databases.transparent_data_encryption_key_vault_key_id, null)
  creation_source_database_id                                = try(var.databases.creation_source_database_id, null)
  restore_dropped_database_id                                = try(var.databases.restore_dropped_database_id, null)
  restore_long_term_retention_backup_id                      = try(var.databases.restore_long_term_retention_backup_id, null)
  recover_database_id                                        = try(var.databases.recover_database_id, null)
  elastic_pool_id                                            = try(var.databases.elastic_pool_id, null)
  tags                                                       = try(var.databases.tags, local.tags)

  dynamic "import" {
    for_each = can(var.databases.identity) ? [1] : []

    content {
      storage_uri                  = var.databases.identity.storage_uri
      storage_key                  = var.databases.identity.storage_key
      storage_key_type             = var.databases.identity.storage_key_type
      administrator_login          = var.databases.identity.administrator_login
      administrator_login_password = var.databases.identity.administrator_login_password
      authentication_type          = var.databases.identity.authentication_type
      storage_account_id           = try(var.databases.identity.storage_account_id, null)
    }
  }

  dynamic "threat_detection_policy" {
    for_each = can(var.databases.threat_detection_policy) ? [1] : []

    content {
      state                      = try(var.databases.threat_detection_policy.state, null)
      disabled_alerts            = try(var.databases.threat_detection_policy.disabled_alerts, null)
      email_account_admins       = try(var.databases.threat_detection_policy.email_account_admins, null)
      email_addresses            = try(var.databases.threat_detection_policy.email_addresses, null)
      retention_days             = try(var.databases.threat_detection_policy.retention_days, null)
      storage_account_access_key = try(var.databases.threat_detection_policy.storage_account_access_key, null)
      storage_endpoint           = try(var.databases.threat_detection_policy.storage_endpoint, null)
    }
  }

  dynamic "long_term_retention_policy" {
    for_each = can(var.databases.long_term_retention_policy) ? [1] : []

    content {
      weekly_retention          = try(var.databases.long_term_retention_policy.weekly_retention, null)
      monthly_retention         = try(var.databases.long_term_retention_policy.monthly_retention, null)
      yearly_retention          = try(var.databases.long_term_retention_policy.yearly_retention, null)
      week_of_year              = try(var.databases.long_term_retention_policy.week_of_year, null)
      immutable_backups_enabled = try(var.databases.long_term_retention_policy.immutable_backups_enabled, null)
    }
  }

  dynamic "short_term_retention_policy" {
    for_each = can(var.databases.short_term_retention_policy) ? [1] : []

    content {
      retention_days           = var.databases.short_term_retention_policy.retention_days
      backup_interval_in_hours = try(var.databases.short_term_retention_policy.backup_interval_in_hours, null)
    }
  }

  dynamic "identity" {
    for_each = can(var.databases.identity) ? [1] : []

    content {
      type         = var.databases.identity.type
      identity_ids = try(var.databases.identity.identity_ids, null)
    }
  }
}
