module "virtual_networks" {
  source   = "./modules/_networking/virtual_networks"
  for_each = var.virtual_networks
  settings = each.value
  resources = {
    resource_groups = module.resource_groups
  }
}
