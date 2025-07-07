locals {
  network_interface_id = try(
    var.resources[
      try(var.settings.nic_lz_key, var.client_config.landingzone_key)
    ].network_interfaces[var.settings.network_interface_ref].id,
    var.settings.network_interface_id
  )

  network_security_group_id = try(
    var.resources[
      try(var.settings.nsg_lz_key, var.client_config.landingzone_key)
    ].network_security_groups[var.settings.network_security_group_ref].id,
    var.settings.network_security_group_ref
  )
}
