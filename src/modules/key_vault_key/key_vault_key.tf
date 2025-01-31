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
    for_each = can(var.settings.rotation_policy) ? [1] : []

    content {
      expire_after         = try(var.settings.rotation_policy.expire_after, null)
      notify_before_expiry = try(var.settings.rotation_policy.notify_before_expiry, null)

      dynamic "automatic" {
        for_each = can(var.settings.rotation_policy.automatic) ? [1] : []

        content {
          time_after_creation = try(var.settings.rotation_policy.automatic.time_after_creation, null)
          time_before_expiry  = try(var.settings.rotation_policy.automatic.time_before_expiry, null)
        }
      }
    }
  }
}

# resource "null_resource" "cluster" {
#   triggers = {
#     cluster_instance_ids = join(",", aws_instance.cluster[*].id)
#   }
# }

resource "local_file" "foo" {
  content  = jsonencode(var.settings.rotation_policy[*])
  filename = "debug"
}
