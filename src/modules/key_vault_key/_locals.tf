locals {
  key_vault_id = var.resources.keyvaults[var.settings.key_vault_ref].id

  tags = merge(
    var.global_settings.tags,
    try(var.settings.tags, {})
  )
}
