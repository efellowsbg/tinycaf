locals {
  subnet_lz_key = (
    try(var.settings.lz_key, null) != null ?
    var.settings.lz_key :
    try(var.settings.sub_lz_key, var.client_config.landingzone_key)
  )

  nsg_lz_key = (
    try(var.settings.lz_key, null) != null ?
    var.settings.lz_key :
    try(var.settings.nsg_lz_key, var.client_config.landingzone_key)
  )

  subnet_id = try(
    var.resources[local.subnet_lz_key]
    .virtual_networks[split("/", var.settings.subnet_ref)[0]]
    .subnets[split("/", var.settings.subnet_ref)[1]]
    .id,
    var.settings.subnet_id
  )

  network_security_group_id = try(
    var.resources[local.nsg_lz_key]
    .network_security_groups[var.settings.network_security_group_ref]
    .id,
    var.settings.network_security_group_id
  )
}
