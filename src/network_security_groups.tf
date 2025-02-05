module "network_security_groups" {
  source   = "./modules/network_security_group"
  for_each = var.network_security_groups

  settings        = each.value
  global_settings = local.global_settings

  resources = {
    resource_groups = module.resource_groups
  }
}
