data "azuread_user" "main" {
  user_principal_name = var.settings.email
}
# TODO: github provider
