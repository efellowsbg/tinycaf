module "bastion_hosts" {
  source   = "./modules/bastion_host"
  for_each = var.bastion_hosts

  settings        = each.value
  global_settings = local.global_settings


  resources = merge(
    {
      (var.landingzone.key) = {
        resource_groups  = module.resource_groups
        virtual_networks = module.virtual_networks
        public_ips       = module.public_ips
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
