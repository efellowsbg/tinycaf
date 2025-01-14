locals {
  vnet1 = var.resources.virtual_networks[var.settings.vnet1_ref]
  vnet2 = var.resources.virtual_networks[var.settings.vnet2_ref]
}

locals {
  peerings = {
    "vnet1_to_vnet2" = {
      source_vnet = local.vnet1
      target_vnet = local.vnet2
      direction   = "1to2"
    }
    "vnet2_to_vnet1" = {
      source_vnet = local.vnet2
      target_vnet = local.vnet1
      direction   = "2to1"
    }
  }
}
