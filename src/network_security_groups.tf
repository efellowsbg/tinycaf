module "network_security_groups" {
  source = "./modules/network_security_group"

  settings        = var.network_security_groups
  global_settings = local.global_settings

  resources = {
    resource_groups = module.resource_groups
  }
}
