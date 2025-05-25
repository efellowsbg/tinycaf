locals {
  resource_group = var.resources[
    try(var.settings.lz_key, var.client_config.landingzone_key)
 ].resource_groups[var.settings.resource_group_ref]
  resource_group_name = local.resource_group.name
  location            = local.resource_group.location

  subnet_id = var.resources[
  try(var.settings.subnet_lz_key, var.client_config.landingzone_key)
].virtual_networks[
  split("/", var.settings.subnet_ref)[0]
].subnets[
  split("/", var.settings.subnet_ref)[1]
].id

  identity_ids = [
  for id_ref in try(var.settings.identity.identity_ids_ref, []) :
  var.resources[
    try(var.settings.identity.managed_identity_lz_key, var.client_config.landingzone_key)
  ].managed_identities[id_ref].id
]
  key_vault_id = try(
  var.resources[
    try(var.settings.key_vault_lz_key, var.client_config.landingzone_key)
  ].keyvaults[
    var.settings.key_vault_ref
  ].id,
  null
)

  tags = merge(
    var.global_settings.tags,
    var.global_settings.inherit_resource_group_tags ? local.resource_group.tags : {},
    try(var.settings.tags, {})
  )
}
