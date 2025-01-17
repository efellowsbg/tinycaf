module "linux_virtual_machines" {
  source   = "./modules/linux_virtual_machines"
  for_each = var.linux_virtual_machines

  settings        = each.value
  global_settings = var.global_settings

  resources = {
    resource_groups = module.resource_groups
  }
}
