module "placement_groups" {
  source   = "./modules/placement_group"
  for_each = var.placement_groups

  settings        = each.value
  global_settings = local.global_settings
  client_config = {
    landingzone_key = var.landingzone.key
  }
}
