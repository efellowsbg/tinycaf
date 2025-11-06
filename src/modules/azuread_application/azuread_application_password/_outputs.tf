output "key_id" {
  value       = azuread_application_password.main.key_id
  description = "Client secret key id"
}

output "value" {
  value       = azuread_application_password.main.value
  description = "Client secret value"
  sensitive   = true
}
