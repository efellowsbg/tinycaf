resource "azuread_administrative_unit" "main" {
  display_name              = var.settings.description
  description               = try(var.settings.description, null)
  members                   = try(var.settings.members, null)
  hidden_membership_enabled = try(var.settings.hidden_membership_enabled, null)
}
