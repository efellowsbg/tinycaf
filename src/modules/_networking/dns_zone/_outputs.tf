output "id" {
  value = azurerm_dns_zone.main.id
}

output "name_servers" {
  value = azurerm_dns_zone.main.name_servers
}

output "name" {
  value = azurerm_dns_zone.main.name
}

output "txt_record_ids" {
  value = { for k, r in azurerm_dns_txt_record.main : k => r.id }
}

output "txt_record_fqdns" {
  value = { for k, r in azurerm_dns_txt_record.main : k => r.fqdn }
}
