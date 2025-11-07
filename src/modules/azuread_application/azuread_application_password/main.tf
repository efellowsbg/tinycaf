resource "azuread_application_password" "main" {
  application_id      = var.application_id
  display_name        = try(var.settings.create_password.display_name, null)
  end_date            = try(var.settings.create_password.end_date, null)
  rotate_when_changed = try(var.settings.create_password.rotate_when_changed, null)
  start_date          = try(var.settings.create_password.start_date, null)
}
