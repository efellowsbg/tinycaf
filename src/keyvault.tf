module "keyvaults" {
  source   = "./modules/_security/keyvault"
  for_each = var.keyvaults

  settings        = each.value
  global_settings = local.global_settings
  resources = {
    virtual_networks = module.virtual_networks
    public_ips       = module.public_ips
    resource_groups  = module.resource_groups
  }
}