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
  value = azuread_application_password.main.key_id
}

output "client_scret_value" {
  value = azuread_application_password.main.value
}
