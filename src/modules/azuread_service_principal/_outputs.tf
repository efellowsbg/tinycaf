output "object_id" {
  value = azuread_service_principal.main.object_id
}

output "app_role_ids" {
  value = azuread_service_principal.main.app_role_ids
}

output "app_roles" {
  value = azuread_service_principal.main.app_roles
}

output "display_name" {
  value = azuread_service_principal.main.display_name
}

output "oauth2_permission_scope_ids" {
  value = azuread_service_principal.main.oauth2_permission_scope_ids
}

output "type" {
  value = azuread_service_principal.main.type
}
