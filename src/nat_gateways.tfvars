module "nat_gateways" {
  source = "./modules/nat_gateway"

  settings        = var.nat_gateways
  global_settings = local.global_settings

  resources = {
    resource_groups = module.resource_groups
  }
}
