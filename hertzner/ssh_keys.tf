module "ssh_keys" {
  source   = "./modules/ssh_key"
  for_each = var.ssh_keys

  settings        = each.value
  global_settings = local.global_settings
  client_config = {
    landingzone_key = var.landingzone.key
  }
}
