module "mssql_elasticpools" {
  source   = "./mssql_elasticpool"
  for_each = try(var.settings.elasticpools, {})

  settings          = var.settings
  mssql_server_name = azurerm_mssql_server.main.name
  elasticpools      = each.value
  elastic_name      = each.key
  global_settings   = var.global_settings
  resources         = var.resources
  client_config     = var.client_config
}
