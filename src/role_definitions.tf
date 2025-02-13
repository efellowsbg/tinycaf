module "role_definitions" {
  source   = "./modules/role_definition"
  for_each = var.role_definitions

  settings        = each.value
  global_settings = local.global_settings

  resources = {}
}
