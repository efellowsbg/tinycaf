module "managed_disks" {
  source   = "./modules/managed_disk"
  for_each = var.managed_disks

  settings        = each.value
  global_settings = local.global_settings

  resources = {
    resource_groups     = module.resource_groups
  }
}