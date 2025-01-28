locals {
  resource_group      = var.resources.resource_groups[var.settings.resource_group_ref]
  resource_group_name = local.resource_group.name
  location            = local.resource_group.location

  # identity_ids = flatten([
  #   for key, value in try(var.settings.identity, []) : [
  #     for id_ref in value.identity_ids_ref : var.resources.managed_identities[id_ref].id
  #   ]
  # ])

  identity_ids = [
    for id_ref in try(var.settings.identity.identity_ids_ref, []) :
    var.resources.managed_identities[id_ref].id
  ]

  tags = merge(
    var.global_settings.tags,
    var.global_settings.inherit_resource_group_tags ? local.resource_group.tags : {},
    try(var.settings.tags, {})
  )
}
