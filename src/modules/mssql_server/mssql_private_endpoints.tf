module "mssql_endpoint" {
  source = "./mssql_private_endpoint"

  count = try(var.settings.private_endpoint != null, false) ? 1 : 0

  settings        = var.settings
  mssql_server_id = azurerm_mssql_server.main.id
  subnet_ref      = var.settings.private_endpoint.subnet_ref
  global_settings = var.global_settings
  resources       = var.resources
  client_config   = var.client_config
}
