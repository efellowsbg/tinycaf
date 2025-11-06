# module "azuread_application_passwords" {
#   source   = "./azuread_application_password"
#   count = try(var.settings.create_password, null) == null ? 0 : 1

#   settings        = var.settings
#   application_id     = azuread_application.main.id
#   global_settings = var.global_settings
#   resources       = var.resources
#   client_config   = var.client_config
# }
