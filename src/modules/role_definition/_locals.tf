locals {
  # scope_resource = var.resources.resource_group_ref[var.settings.scoper_ref]
  scope_id = local.scope_resource.id

  scope_resource = [for module_ref, module in var.resources :
    try(module[var.settings.scoper_ref], null)
  ]
}
