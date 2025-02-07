locals {
  resource_group      = var.resources.resource_groups[var.settings.resource_group_ref]
  resource_group_name = local.resource_group.name
  location            = local.resource_group.location

  # network_security_group_id = try(var.resources.network_security_groups[var.settings.subnets.network_security_group_ref].id, null)

  subnet_ids = { for k, v in azurerm_subnet.main : k => v.id }

  network_security_group_ids = {
    for k, v in var.settings.subnets :
    k => try(var.resources.network_security_groups[v.network_security_group_ref].id, null)
  }

  # local object used to map short delegation refs to full delegation "objects"
  delegations = {
    "sql_managed_instance" = {
      name                    = "managedinstancedelegation"
      service_delegation_name = "Microsoft.Sql/managedInstances"
      service_delegation_actions = [
        "Microsoft.Network/virtualNetworks/subnets/join/action",
        "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action",
        "Microsoft.Network/virtualNetworks/subnets/unprepareNetworkPolicies/action"
      ]
    }
  }

  tags = merge(
    var.global_settings.tags,
    var.global_settings.inherit_resource_group_tags ? local.resource_group.tags : {},
    try(var.settings.tags, {})
  )
}
