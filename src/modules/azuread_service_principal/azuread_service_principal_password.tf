resource "azuread_service_principal_password" "main" {
  service_principal_id = azuread_service_principal.main.id

  display_name = var.settings.password_display_name
  start_date   = try(var.settings.password_start_date, null)
  end_date     = try(var.settings.password_end_date, null)
}
