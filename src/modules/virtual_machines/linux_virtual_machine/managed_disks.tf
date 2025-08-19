module "managed_disks" {
  source = "../../managed_disks"
  for_each = var.settings.data_disks

  settings        = each.value
  global_settings = var.global_settings
  resources       = var.resources
  client_config   = var.client_config
}