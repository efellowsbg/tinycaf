output "id" {
  value = azuread_application.main.id
}

output "client_id" {
  value = azuread_application.main.client_id
}

output "principal_id" {
  value = azuread_application.main.object_id
}

output "pass_key_id" {
  value       = length(azuread_application_password.main) > 0 ? azuread_application_password.main[0].key_id : null
  description = "Client secret key id"
}

output "client_secret_value" {
  value       = length(azuread_application_password.main) > 0 ? azuread_application_password.main[0].value : null
  description = "Client secret value"
  sensitive   = true
}
