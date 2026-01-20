resource "azurerm_mssql_failover_group" "main" {
  name      = var.settings.name
  server_id = local.primary_server_id

  partner_server {
    id = local.secondary_server_id
  }

  databases = local.database_ids

  dynamic "read_write_endpoint_failover_policy" {
    for_each = (
      try(var.settings.read_write_endpoint_failover_policy.mode, "Automatic") == "Manual"
      ? [1]
      : []
    )

    content {
      mode = "Manual"
    }
  }

  dynamic "read_write_endpoint_failover_policy" {
    for_each = (
      try(var.settings.read_write_endpoint_failover_policy.mode, "Automatic") != "Manual"
      ? [1]
      : []
    )

    content {
      mode          = try(var.settings.read_write_endpoint_failover_policy.mode, "Automatic")
      grace_minutes = try(var.settings.read_write_endpoint_failover_policy.grace_minutes, 60)
    }
  }
  readonly_endpoint_failover_policy_enabled = try(
    var.settings.readonly_endpoint_failover_policy.enabled,
    false
  )

  tags = local.tags

}
