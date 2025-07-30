locals {
  resource_group = var.resources[
    try(var.settings.lz_key, var.client_config.landingzone_key)
  ].resource_groups[var.settings.resource_group_ref]
  resource_group_name = local.resource_group.name
  location            = local.resource_group.location

  keyvault_id = try(
    var.resources[
      try(var.settings.keyvault_lz_key, var.client_config.landingzone_key)
    ].keyvaults[local.keyvault_ref].id,
    null
  )

  egress_nat_rule_ids = try([
    for nat_rule_ref in try(var.settings.egress_nat_rule_refs, []) :
    var.resources[
      try(var.settings.lz_key, var.client_config.landingzone_key)
    ].virtual_network_gateways[var.settings.virtual_network_gateway_ref].nat_rule_ids[nat_rule_ref].id
  ], [])

  local_network_gateway_id = try(
    var.resources[
      try(var.settings.local_network_gateway_lz_key, var.client_config.landingzone_key)
    ].local_network_gateways[var.settings.local_network_gateway_ref].id,
    null
  )

  virtual_network_gateway_id = try(
    var.resources[
      try(var.settings.virtual_network_gateway_lz_key, var.client_config.landingzone_key)
    ].virtual_network_gateways[var.settings.virtual_network_gateway_ref].id,
    null
  )


  keyvault_ref = try(
    element(split("/", var.settings.shared_key_secret), 0),
    null
  )

  secret_name = try(
    element(split("/", var.settings.shared_key_secret), 1),
    null
  )

  tags = merge(
    var.global_settings.tags,
    var.global_settings.inherit_resource_group_tags ? local.resource_group.tags : {},
    try(var.settings.tags, {})
  )
}
