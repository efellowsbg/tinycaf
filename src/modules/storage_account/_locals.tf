locals {
  resource_group = var.resources.resource_groups[var.settings.resource_group_ref]
  resource_group_name = local.resource_group.name
  location = local.resource_group.location

  # vnet = var.resources.virtual_networks[var.settings.network.config.vnet_ref]

  # subnet_id = local.vnet.subnets[var.settings.network.subnet_ref].id
  # subnet_id = [for config in values(local.storage_account_network) : local.virtual_networks[config.vnet_ref].subnets[config.subnet_ref].id]
  subnet_id = [
    for config in var.settings.network : 
    var.resources.virtual_networks[var.settings.network.config.value.vnet_ref].subnets[var.settings.network.config.value.subnet_ref].id
  ]

  # subnet_id = [
  #   for config in var.settings.network : 
  #   {vnet = config.vnet_ref
    
  #   }
  # ]

#  subnet_id = flatten([
#     for config, account_data in var.storage_accounts : [
#       for config_name, config in account_data.network : {
#         vnet_ref   = config.vnet_ref
#         subnet_ref = config.subnet_ref
#       }
#     ]
#   ])

  tags = merge(
    var.global_settings.tags,
    var.global_settings.inherit_resource_group_tags ? local.resource_group.tags : {},
    try(var.settings.tags, {})
  )
}