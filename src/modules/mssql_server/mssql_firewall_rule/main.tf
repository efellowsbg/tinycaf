resource "azurerm_mssql_firewall_rule" "main" {
  name             = try(var.rules.name, var.rule_name)
  server_id        = var.mssql_server_id
  start_ip_address = var.rules.start_ip_address
  end_ip_address   = var.rules.end_ip_address
}
