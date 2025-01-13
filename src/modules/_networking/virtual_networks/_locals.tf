locals {
  resource_group = var.resources.resource_groups[var.settings.resource_group_ref]

  resource_group_name = local.resource_group.name
  location            = local.resource_group.location
  tags                = try(local.resource_group.tags, null)
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
