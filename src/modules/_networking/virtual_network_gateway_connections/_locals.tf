locals {
  resource_group = var.resources.resource_groups[var.settings.resource_group_ref]

  resource_group_name = local.resource_group.name
  location            = local.resource_group.location

  tags = merge(
    var.global_settings.tags,
    var.global_settings.inherit_resource_group_tags ? local.resource_group.tags : {},
    try(var.settings.tags, {})
  )
}

locals {
  keyvault_ref = try(
    element(split("/", var.settings.shared_key_secret), 0),
    null
  )
  secret_name = try(
    element(split("/", var.settings.shared_key_secret), 1),
    null
  )
  keyvault_id = try(var.resources.keyvaults[local.keyvault_ref].id, null)
}

locals {
  local_network_gateway_id   = try(var.resources.local_network_gateways[var.settings.local_network_gateway_ref].id, null)
  virtual_network_gateway_id = try(var.resources.virtual_network_gateways[var.settings.virtual_network_gateway_ref].id, null)
}
