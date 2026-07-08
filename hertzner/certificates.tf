module "managed_certificates" {
  source   = "./modules/managed_certificate"
  for_each = var.managed_certificates

  settings        = each.value
  global_settings = local.global_settings
  client_config = {
    landingzone_key = var.landingzone.key
  }
}

module "uploaded_certificates" {
  source   = "./modules/uploaded_certificate"
  for_each = var.uploaded_certificates

  settings        = each.value
  global_settings = local.global_settings
  client_config = {
    landingzone_key = var.landingzone.key
  }
}
