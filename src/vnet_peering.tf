module "vnet_peering" {
  source          = "./modules/_networking/vnet_peering"
  for_each        = var.vnet_peering
  global_settings = var.global_settings
  settings        = each.value
  resources = {
    virtual_networks = module.virtual_networks
  }
}
