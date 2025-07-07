module "kubernetes_clusters" {
  source   = "./modules/compute/kubernetes"
  for_each = var.kubernetes_clusters

  settings        = each.value
  global_settings = local.global_settings


  resources = merge(
    {
      (var.landingzone.key) = {
        virtual_networks   = module.virtual_networks
        resource_groups    = module.resource_groups
        managed_identities = module.managed_identities
        private_dns_zones  = module.private_dns_zones
      }
    },
    {
      for k, v in module.remote_states : k => v.outputs
    }
  )
  client_config = {
    landingzone_key = var.landingzone.key
  }
}
