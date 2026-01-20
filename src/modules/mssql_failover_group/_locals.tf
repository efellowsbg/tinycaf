locals {
  primary_server = var.resources[
    try(var.settings.primary.lz_key, var.client_config.landingzone_key)
  ].mssql_servers[var.settings.primary.server_ref]

  secondary_server = try(
    var.resources[
      try(var.settings.secondary.lz_key, var.client_config.landingzone_key)
    ].mssql_servers[var.settings.secondary.server_ref],
    null
  )

  primary_server_id = local.primary_server.id
  secondary_server_id = try(
    local.secondary_server.id,
    var.settings.secondary.server_id
  )

  database_ids = [
    for db_ref in sort(try(var.settings.database_refs, [])) :
    local.primary_server.databases[db_ref].id
  ]

  tags = merge(
    var.global_settings.tags,
    var.global_settings.inherit_resource_group_tags ? local.resource_group.tags : {},
    try(var.settings.tags, {})
  )
}
