module "container_groups" {
  source   = "./modules/container_group"
  for_each = var.container_groups

  settings        = each.value
  global_settings = local.global_settings

  resources = {
    resource_groups = module.resource_groups
  }
}
