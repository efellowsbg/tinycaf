output "id" {
  value = azurerm_dns_zone.main.id
}

output "name_servers" {
  value = azurerm_dns_zone.main.name_servers
}

output "name" {
  value = azurerm_dns_zone.main.name
}

output "txt_record_id" {
  value = azurerm_dns_txt_record.main.id
}

output "txt_record_fqdn" {
  value = azurerm_dns_txt_record.main.fqdn
}
