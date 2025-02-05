module "nat_gateways" {
  for_each = var.nat_gateways
  source   = "./modules/nat_gateway"

  settings        = each.value
  global_settings = local.global_settings

  resources = {
    resource_groups = module.resource_groups
  }
}
