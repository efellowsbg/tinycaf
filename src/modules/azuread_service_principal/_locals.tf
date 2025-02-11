locals {
  client_id = try(var.resources.azuread_applications[var.settings.client_id_ref], var.settings.client_id_ref)

  tags = merge(
    var.global_settings.tags,
    try(var.settings.tags, {})
  )
}
