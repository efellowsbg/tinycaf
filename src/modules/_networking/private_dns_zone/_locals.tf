locals {
  resource_group       = var.resources.resource_groups[var.settings.resource_group_ref]
  resource_group_name  = local.resource_group.name
  location             = local.resource_group.location
  registration_enabled = try(var.settings.registration_enabled, false)

  vnet_refs = (
    try(length(var.settings.vnet_ref), 0) > 0 ?
    {
      for vnet in var.settings.vnet_ref :
      vnet => {
        name = var.resources.virtual_networks[vnet].name
        id   = var.resources.virtual_networks[vnet].id
      }
    } : {}
  )
  vnet_ids_cleaned = try({
    for vnet_id in var.settings.vnet_ids :
    vnet_id => {
      name = split("/", vnet_id)[length(split("/", vnet_id)) - 1]
      id   = vnet_id
    }
  }, {})

  # Final merged map of all vNets
  vnet_ids = merge(local.vnet_refs, local.vnet_ids_cleaned)

  # local object used to map possible private dns zoone names
  zone_names = {
    "storage_blob"         = "privatelink.blob.core.windows.net"
    "storage_tables"       = "privatelink.table.core.windows.net"
    "storage_queues"       = "privatelink.queue.core.windows.net"
    "storage_files"        = "privatelink.file.core.windows.net"
    "function_apps"        = "privatelink.azurewebsites.net"
    "keyvaults"            = "privatelink.vaultcore.azure.net"
    "container_registries" = "privatelink.azurecr.io"
  }

  tags = merge(
    var.global_settings.tags,
    var.global_settings.inherit_resource_group_tags ? local.resource_group.tags : {},
    try(var.settings.tags, {})
  )
}
