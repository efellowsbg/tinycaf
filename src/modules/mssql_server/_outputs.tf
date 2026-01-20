output "id" {
  value = azurerm_mssql_server.main.id
}

output "name" {
  value = azurerm_mssql_server.main.name
}

output "fully_qualified_domain_name" {
  value = azurerm_mssql_server.main.fully_qualified_domain_name
}

output "databases" {
  description = "Map of database refs to database module outputs (includes id)"
  value       = module.mssql_databases
}
