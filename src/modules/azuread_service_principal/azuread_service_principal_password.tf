# resource "time_rotating" "main" {
#   rotation_days = 7
# }

resource "azuread_service_principal_password" "main" {
  service_principal_id = azuread_service_principal.main.id
  #  rotate_when_changed = {
  #   rotation = time_rotating.main.id
  # }
}
