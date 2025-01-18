# Initial policy is used to address a a bootstrap condition during the launchpad deployment
module "initial_policy" {
  source = "./keyvault_access_policy"
  count  = try(var.settings.access_policies, null) == null ? 0 : 1
  settings        = each.value
  keyvault_id     = module.keyvaults[each.key].id
  access_policies = var.settings.access_policies
  resources = {
    virtual_networks   = module.virtual_networks
    resource_groups    = module.resource_groups
    managed_identities = module.managed_identities
    private_dns_zones  = module.private_dns_zones
    keyvaults = module.keyvaults
  }
  global_settings = var.global_settings
}
