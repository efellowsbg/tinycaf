locals {
  client_id = try(var.resources.azuread_applications[var.settings.client_id_ref], var.settings.client_id_ref)

  tags = merge(
    var.global_settings.tags,
    var.global_settings.inherit_resource_group_tags ? local.resource_group.tags : {},
    try(var.settings.tags, {})
  )
}
