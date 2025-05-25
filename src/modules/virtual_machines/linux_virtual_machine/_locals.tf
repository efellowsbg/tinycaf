locals {
  resource_group = var.resources[
    try(var.settings.lz_key, var.client_config.landingzone_key)
  ].resource_groups[var.settings.resource_group_ref]
  resource_group_name = local.resource_group.name
  location            = local.resource_group.location

  network_interface_ids = module.network_interface.ids

  key_vault_id = var.resources[
    try(var.settings.keyvault_lz_key, var.client_config.landingzone_key)
    ].keyvaults[
    var.settings.keyvault_ref
  ].id

  vm_keys = { for key, ssh_key in var.settings.admin_ssh_key :
    key => tls_private_key.main[ssh_key.public_key_ref]
  }
  private_keys_pem    = { for key, value in local.vm_keys : key => value.private_key_pem }
  public_keys_openssh = { for key, value in local.vm_keys : key => value.public_key_openssh }

  tags = merge(
    var.global_settings.tags,
    var.global_settings.inherit_resource_group_tags ? local.resource_group.tags : {},
    try(var.settings.tags, {})
  )
}
