locals {

  tags = merge(
    var.global_settings.tags,
    var.global_settings.inherit_resource_group_tags ? local.resource_group.tags : {},
    try(var.settings.tags, {})
  )

  subnet_id = try(
    var.resources[
      try(var.settings.subnet_lz_key, var.client_config.landingzone_key)
      ].virtual_networks[
      split("/", var.settings.subnet_ref)[0]
      ].subnets[
      split("/", var.settings.subnet_ref)[1]
    ].id,
    var.settings.subnet_id
  )
}
