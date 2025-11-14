output "id" {
  value = azuread_application.main.id
}

output "client_id" {
  value = azuread_application.main.client_id
}

output "principal_id" {
  value = azuread_application.main.object_id
}

output "display_name" {
  value = azuread_application.main.display_name
}
