locals {
  resource_group = var.resources[
    try(var.settings.lz_key, var.client_config.landingzone_key)
  ].resource_groups[var.settings.resource_group_ref]

  resource_group_name  = local.resource_group.name
  location             = local.resource_group.location
  registration_enabled = try(var.settings.registration_enabled, false)

  vnet_links_refs = try(length(var.settings.vnet_links), 0) > 0 ? {
    for link_key, link in var.settings.vnet_links : link_key => {
      name_exact = try(link.name, null)

      name = try(
        link.name,
        var.resources[
          length(split("/", link.vnet_ref)) > 1 ?
          split("/", link.vnet_ref)[0] :
          try(var.settings.lz_key, var.client_config.landingzone_key)
          ].virtual_networks[
          length(split("/", link.vnet_ref)) > 1 ?
          split("/", link.vnet_ref)[1] :
          link.vnet_ref
        ].name
      )

      id = var.resources[
        length(split("/", link.vnet_ref)) > 1 ?
        split("/", link.vnet_ref)[0] :
        try(var.settings.lz_key, var.client_config.landingzone_key)
        ].virtual_networks[
        length(split("/", link.vnet_ref)) > 1 ?
        split("/", link.vnet_ref)[1] :
        link.vnet_ref
      ].id
    }
  } : {}

  vnet_ids_cleaned = try({
    for vnet_id in var.settings.vnet_ids :
    vnet_id => {
      name       = split("/", vnet_id)[length(split("/", vnet_id)) - 1]
      id         = vnet_id
      name_exact = null
    }
  }, {})

  vnet_ids = merge(local.vnet_links_refs, local.vnet_ids_cleaned)

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
