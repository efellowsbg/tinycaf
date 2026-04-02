module "snapshots" {
  source   = "./modules/snapshot"
  for_each = var.snapshots

  settings        = each.value
  global_settings = local.global_settings

  resources = {
    (var.landingzone.key) = {
      servers = module.servers
    }
  }
  client_config = {
    landingzone_key = var.landingzone.key
  }
}
