module "waf_policies" {
  for_each = var.waf_policies
  source   = "./modules/_security/web_application_firewall_policy"

  settings        = each.value
  global_settings = var.global_settings



  resources = merge(
    {
      (var.landingzone.key) = {
        resource_groups = module.resource_groups
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
