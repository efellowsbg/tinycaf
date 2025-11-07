resource "azuread_group" "main" {
  # TODO Add support for administrative_unit references
  display_name               = var.settings.display_name
  owners                     = try(toset(var.settings.owners), [var.global_settings.object_id])
  administrative_unit_ids    = try(var.settings.administrative_unit_ids, null)
  assignable_to_role         = try(var.settings.assignable_to_role, null)
  auto_subscribe_new_members = try(var.settings.auto_subscribe_new_members, null)
  behaviors                  = try(var.settings.behaviors, null)
  description                = try(var.settings.description, null)
  external_senders_allowed   = try(var.settings.external_senders_allowed, null)
  hide_from_address_lists    = try(var.settings.hide_from_address_lists, null)
  hide_from_outlook_clients  = try(var.settings.hide_from_outlook_clients, null)
  mail_enabled               = try(var.settings.mail_enabled, null)
  mail_nickname              = try(var.settings.mail_nickname, null)
  members                    = try(var.settings.members, null)
  onpremises_group_type      = try(var.settings.onpremises_group_type, null)
  prevent_duplicate_names    = try(var.settings.prevent_duplicate_names, null)
  provisioning_options       = try(var.settings.provisioning_options, null)
  security_enabled           = try(var.settings.security_enabled, null)
  theme                      = try(var.settings.theme, null)
  types                      = try(var.settings.types, null)
  visibility                 = try(var.settings.visibility, null)
  writeback_enabled          = try(var.settings.writeback_enabled, null)

  dynamic "dynamic_membership" {
    for_each = can(var.settings.dynamic_membership) ? [1] : []
    content {
      enabled = var.settings.dynamic_membership.enabled
      rule    = var.settings.dynamic_membership.rule
    }
  }
}
