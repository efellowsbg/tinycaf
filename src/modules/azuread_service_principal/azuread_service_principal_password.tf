# resource "time_rotating" "main" {
#   rotation_days = 7
# }

resource "azuread_service_principal_password" "main" {
  count                = var.create_password ? 1 : 0
  service_principal_id = azuread_service_principal.main.id
  #  rotate_when_changed = {
  #   rotation = time_rotating.main.id
  # }
}
