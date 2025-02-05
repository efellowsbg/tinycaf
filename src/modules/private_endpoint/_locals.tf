locals {
  resource_group      = var.resources.resource_groups[var.settings.resource_group_ref]
  resource_group_name = local.resource_group.name
  location            = local.resource_group.location

  subnet_id = try(
    var.resources.virtual_networks[split("/", var.settings.subnet_ref)[0]].subnets[split("/", var.settings.subnet_ref)[1]].id,
    null
  )
  resource_type                  = var.resource_type
  private_connection_resource_id = module.resource_type[var.resource_ref].id

  # resource_types_map = {
  #   "storage_account" = module.storage_accounts
  # }

  tags = merge(
    var.global_settings.tags,
    var.global_settings.inherit_resource_group_tags ? local.resource_group.tags : {},
    try(var.settings.tags, {})
  )
}
