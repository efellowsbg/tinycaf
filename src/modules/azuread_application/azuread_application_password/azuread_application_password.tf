# resource "azuread_application_password" "main" {
#   count = try(var.settings.create_password, null) == null ? 0 : 1

#   application_id      = azuread_application.main.id
#   display_name        = try(var.settings.create_password.display_name, null)
#   end_date            = try(var.settings.create_password.end_date, null)
#   rotate_when_changed = try(var.settings.create_password.rotate_when_changed, null)
#   start_date          = try(var.settings.create_password.start_date, null)
# }

# module "azuread_application_passwords" {
#   source   = "./modules/azuread_application"
#   for_each = var.azuread_applications
#   settings        = each.value
#   global_settings = local.global_settings

#   client_config = {
#     landingzone_key = var.landingzone.key
#   }

#   resources = merge(
#     {
#       (var.landingzone.key) = {
#       }
#     },
#     {
#       for k, v in module.remote_states : k => v.outputs
#     }
#   )
# }
