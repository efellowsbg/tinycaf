output "pass_key_id" {
  value       = azuread_application_password.main.key_id
  description = "Client secret key id"
}

output "client_secret_value" {
  value       = azuread_application_password.main.value
  description = "Client secret value"
  sensitive   = true
}
