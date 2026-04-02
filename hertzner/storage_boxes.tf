module "storage_boxes" {
  source   = "./modules/storage_box"
  for_each = var.storage_boxes

  settings        = each.value
  global_settings = local.global_settings
  client_config = {
    landingzone_key = var.landingzone.key
  }
}

module "storage_box_snapshots" {
  source   = "./modules/storage_box_snapshot"
  for_each = var.storage_box_snapshots

  settings        = each.value
  global_settings = local.global_settings

  resources = {
    (var.landingzone.key) = {
      storage_boxes = module.storage_boxes
    }
  }
  client_config = {
    landingzone_key = var.landingzone.key
  }
}

module "storage_box_subaccounts" {
  source   = "./modules/storage_box_subaccount"
  for_each = var.storage_box_subaccounts

  settings        = each.value
  global_settings = local.global_settings

  resources = {
    (var.landingzone.key) = {
      storage_boxes = module.storage_boxes
    }
  }
  client_config = {
    landingzone_key = var.landingzone.key
  }
}
