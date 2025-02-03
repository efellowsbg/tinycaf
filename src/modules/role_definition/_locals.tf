locals {
  scope_id = try([for module_ref, module in var.resources :
    try(module_ref[var.settings.scoper_ref].id, null)
  ][0], null)

  # scope_id = try(local.scope_resource.id, null)
}
