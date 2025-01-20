module "initial_policy" {
  source          = "./keyvault_access_policy"
  for_each        = try(var.settings.access_policies, {})

  settings        = var.settings
  keyvault_id     = module.keyvaults.id
  access_policies = each.value
  policy_name =     each.key
  global_settings = var.global_settings
  resources = var.resources
}
