module "mssql_databases" {
  source   = "./mssql_database"
  for_each = try(var.settings.mssql_databases, {})

  settings        = var.settings
  mssql_server_id = azurerm_mssql_server.main.id
  databases       = each.value
  database_name   = each.key
  global_settings = var.global_settings
  resources       = var.resources
  client_config   = var.client_config
}
