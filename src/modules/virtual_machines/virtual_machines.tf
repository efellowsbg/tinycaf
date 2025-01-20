module "linux_virtual_machine" {
  source = "./linux_virtual_machine"
  # for_each = var.settings.linux_virtual_machine

  settings        = var.settings
  global_settings = var.global_settings

  nic_ids = module.network_interface.nic_ids

  resources = var.resources
}

module "network_interface" {
  source   = "./network_interface"
  for_each = var.settings.network_interface

  settings        = var.settings
  global_settings = var.global_settings

  resources = var.resources
}

# module "windows_virtual_machine" {
#   source   = "./modules/linux_virtual_machine"
#   for_each = var.linux_virtual_machine

#   settings        = each.value
#   global_settings = var.global_settings

#   resources = {
#     resource_groups  = module.resource_groups
#     virtual_networks = module.virtual_networks
#   }
# }
