locals {
  resource_group = var.resources.resource_groups[var.settings.resource_group_ref]

  resource_group_name = local.resource_group.name
  location            = local.resource_group.location
  tags = merge(
    var.global_settings.tags,
    var.global_settings.inherit_resource_group_tags ? local.resource_group.tags : {},
    try(var.settings.tags, {})
  )
  vnet_ids = {
    for vnet in var.settings.vnet_ref :
     vnet => {
      name = var.resources.virtual_networks[vnet].name
      id = var.resources.virtual_networks[vnet].id
  }
}
}
locals {
  # local object used to map possible private dns zoone names
  zone_names = {
    "storage_blob" = "privatelink.blob.core.windows.net"
    "storage_tables" = "privatelink.table.core.windows.net"
    "storage_queues" = "privatelink.queue.core.windows.net"
    "storage_files" = "privatelink.file.core.windows.net"
    "function_apps" = "privatelink.azurewebsites.net"
    "keyvaults" = "privatelink.vaultcore.azure.net"
  }
}
