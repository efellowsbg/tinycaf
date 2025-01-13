locals {
  resource_group = var.resources.resource_groups[var.settings.resource_group_ref]

  resource_group_name = local.resource_group.name
  location            = local.resource_group.location

  tags = merge(
    var.global_settings.tags,
    var.global_settings.inherit_resource_group_tags ? local.resource_group.tags : {},
    var.settings.tags
  )
  virtual_network_peering_1 = var.resources.virtual_networks[var.settings.vnet1_ref]
  virtual_network_peering_2 = var.resources.virtual_networks[var.settings.vnet2_ref]
  peerings = {
    "vnet1_to_vnet2" = {
      source_vnet = local.virtual_network_peering_1
      target_vnet = local.virtual_network_peering_2
      direction   = "1to2"
    }
    "vnet2_to_vnet1" = {
      source_vnet = local.virtual_network_peering_2
      target_vnet = local.virtual_network_peering_1
      direction   = "2to1"
    }
  }
}

locals {
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
}
