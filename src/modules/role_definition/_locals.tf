locals {
  scope_id = try([for module_ref, module in var.resources :
    try(module[var.settings.scope_ref].id, null)
  ][0], null)
}
