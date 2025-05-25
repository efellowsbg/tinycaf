locals {
key_vault_id = var.resources[
  try(var.settings.key_vault_lz_key, var.client_config.landingzone_key)
].keyvaults[
  var.settings.key_vault_ref
].id


  tags = merge(
    var.global_settings.tags,
    try(var.settings.tags, {})
  )
}
