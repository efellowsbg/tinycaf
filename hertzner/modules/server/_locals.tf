locals {
  labels = merge(
    try(var.global_settings.labels, {}),
    try(var.settings.labels, {})
  )

  firewall_ids = try([
    for ref in var.settings.firewall_ids_ref :
    var.resources[
      try(var.settings.firewall_lz_key, var.client_config.landingzone_key)
    ].firewalls[ref].id
  ], null)

  placement_group_id = try(
    var.resources[
      try(var.settings.placement_group_lz_key, var.client_config.landingzone_key)
    ].placement_groups[var.settings.placement_group_ref].id,
    null
  )

  public_net_ipv4 = try(
    var.resources[
      try(var.settings.public_net.ipv4_lz_key, var.client_config.landingzone_key)
    ].primary_ips[var.settings.public_net.ipv4_ref].id,
    null
  )

  public_net_ipv6 = try(
    var.resources[
      try(var.settings.public_net.ipv6_lz_key, var.client_config.landingzone_key)
    ].primary_ips[var.settings.public_net.ipv6_ref].id,
    null
  )
}
