data "azurerm_client_config" "current" {}

module "resource_groups" {
  source   = "./modules/resource_group"
  for_each = var.resource_groups

  settings        = each.value
  global_settings = local.global_settings
}

output "resource_groups" {
  value = module.resource_groups
}

output "debug_static" {
  value = "✅ Output block reached"
}