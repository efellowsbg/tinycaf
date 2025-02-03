locals {
  scope_resource = try([for module_ref, module in var.resources :
    try(module[var.settings.scoper_ref], null)
  ][0], null)

  scope_id = try(local.scope_resource.id, null)
}
