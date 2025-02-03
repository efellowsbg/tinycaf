locals {
  # resource_group = var.resources.resource_groups[var.settings.resource_group_ref]

  scope_id = try([for module_ref, module in var.resources :
    try(module[var.settings.scope_ref].id, null)
  ][0], null)

  # scope_id = try(local.scope_resource.id, null)
}
