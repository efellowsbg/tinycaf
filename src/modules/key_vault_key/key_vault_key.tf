resource "azurerm_key_vault_key" "main" {
  name         = var.settings.name
  key_vault_id = local.key_vault_id
  key_type     = var.settings.key_type
  key_size     = var.settings.key_size
  key_opts     = var.settings.key_opts
  tags         = local.tags

  curve           = try(var.settings.curve, null)
  not_before_date = try(var.settings.not_before_date, null)
  expiration_date = try(var.settings.expiration_date, null)

  #TODO: Implement rotation policy module when created
  dynamic "rotation_policy" {
    for_each = var.settings.rotation_policy[*]

    content {
      expire_after         = try(rotation_policy.value.expire_after, null)
      notify_before_expiry = try(rotation_policy.value.notify_before_expiry, null)

      dynamic "automatic" {
        for_each = try(rotation_policy.automatic[*], {})

        content {
          time_after_creation = try(automatic.value.time_after_creation, null)
          time_before_expiry  = try(automatic.value.time_before_expiry, null)
        }
      }
    }
  }
}
