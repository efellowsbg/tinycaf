locals {
  scope_resource = [for module_ref, module in var.resources :
    try(module[var.settings.scoper_ref], null)
  ]

  scope_id = try(local.scope_resource.id, null)
}
