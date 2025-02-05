module "nat_gateways" {
  source   = "./modules/nat_gateway"
  for_each = var.nat_gateways

  settings        = each.value
  global_settings = local.global_settings

  resources = {
    resource_groups = module.resource_groups
  }
}
