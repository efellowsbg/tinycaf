module "storage_accounts" {
  source = "./modules/storage_account"
  for_each = var.storage_accounts

  settings = each.value
  global_settings = var.global_settings

  resources = {
    resource_groups = module.resource_groups
    vnets = module.virtual_networks
    subnets = module.virtual_networks.subnet_id
  }
}