output "postgresql_server_id" {
  value = try(azurerm_postgresql_server.postgres.id, null)
}

output "postgresql_server_fqdn" {
  value = try(azurerm_postgresql_server.postgres.fqdn, null)
}

output "postgresql_server_identity" {
  value = try(azurerm_postgresql_server.postgres.identity, null)
}
