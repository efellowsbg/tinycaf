locals {
  resource_group      = var.resources.resource_groups[var.settings.resource_group_ref]
  resource_group_name = local.resource_group.name
  location            = local.resource_group.location

  network_interface_ids = module.network_interface.ids

  key_vault_id = var.resources.keyvaults[var.settings.keyvault_ref].id

  vm_key      = tls_private_key.main[var.settings.admin_ssh_key[1].public_key_ref]
  private_key = local.vm_key.private_key_pem
  public_key  = local.vm_key.public_key_openssh

  tags = merge(
    var.global_settings.tags,
    var.global_settings.inherit_resource_group_tags ? local.resource_group.tags : {},
    try(var.settings.tags, {})
  )
}
