locals {
  resource_group = var.resources[
    try(var.settings.lz_key, var.client_config.landingzone_key)
  ].resource_groups[var.settings.resource_group_ref]
  resource_group_name = local.resource_group.name
  location            = local.resource_group.location

  subnet_ids = concat(
    try(var.settings.network_rules.subnet_ids, []),
    compact([
      for network_rule_ref, config in try(var.settings.network_rules.subnets, {}) : (
        try(
          var.resources[
            try(config.lz_key, var.client_config.landingzone_key)
            ].virtual_networks[
            split("/", config.subnet_ref)[0]
            ].subnets[
            split("/", config.subnet_ref)[1]
          ].id,
          null
        )
      )
    ])
  )



  subnet_id = try(
  var.resources[
    try(var.settings.private_endpoint.subnet_lz_key, var.client_config.landingzone_key)
  ].virtual_networks[
    split("/", var.settings.private_endpoint.subnet_ref)[0]
  ].subnets[
    split("/", var.settings.private_endpoint.subnet_ref)[1]
  ].id,
  null
)


  tags = merge(
    var.global_settings.tags,
    var.global_settings.inherit_resource_group_tags ? local.resource_group.tags : {},
    try(var.settings.tags, {})
  )
}
