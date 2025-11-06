output "pass_key_id" {
  value       = azuread_application_password.main[0].key_id
  description = "Client secret key id"
}

output "client_secret_value" {
  value       = azuread_application_password.main[0].value
  description = "Client secret value"
  sensitive   = true
}
