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
  # dynamic "rotation_policy" {
  #   for_each = try(var.settings.rotation_policy, {})

  #   content {
  #     expire_after         = try(each.value.expire_after, null)
  #     notify_before_expiry = try(each.value.notify_before_expiry, null)

  #     dynamic "automatic" {
  #       for_each = try(lookup(each.value, "automatic", {}), {})

  #       content {
  #         time_after_creation = try(each.value.time_after_creation, null)
  #         time_before_expiry  = try(each.value.time_before_expiry, null)
  #       }
  #     }
  #   }
  # }
  dynamic "rotation_policy" {
    for_each = try(var.settings.rotation_policy != null ? [var.settings.rotation_policy] : [], [])

    content {
      expire_after         = try(each.value.expire_after, null)
      notify_before_expiry = try(each.value.notify_before_expiry, null)

      dynamic "automatic" {
        for_each = try(each.value.automatic != null ? [each.value.automatic] : [], [])

        content {
          time_after_creation = try(each.value.time_after_creation, null)
          time_before_expiry  = try(each.value.time_before_expiry, null)
        }
      }
    }
  }
}
