locals {
  subnet_id = try(
    var.resources.virtual_networks[split("/", var.settings.subnet_ref)[0]].subnets[split("/", var.settings.subnet_ref)[1]].id,
    var.settings.subnet_ref
  )

  network_security_group_id = try(var.resources.network_security_groups[var.settings.network_security_group_ref].id, var.settings.network_security_group_ref)
}
