module "resource_groups" {
  source   = "./modules/resource_group"
  for_each = var.resource_groups
  settings = each.value
}

module "managed_identities" {
  source   = "./modules/managed_identity"
  for_each = var.managed_identities
  settings = each.value
  resources = {
    resource_groups = module.resource_groups
  }
}

module "virtual_networks" {
  source   = "./modules/network/virtual_networks"
  for_each = var.virtual_networks
  settings = each.value
  resources = {
    resource_groups = module.resource_groups
  }
}
