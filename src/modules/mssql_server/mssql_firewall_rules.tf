module "mssql_firewall_rules" {
  source   = "./mssql_firewall_rule"
  for_each = try(var.settings.firewall_rules, {})

  settings        = var.settings
  mssql_server_id = azurerm_mssql_server.main.id
  rules           = each.value
  rule_name       = each.key
  global_settings = var.global_settings
  resources       = var.resources
  client_config   = var.client_config
}
