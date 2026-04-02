locals {
  labels = merge(
    try(var.global_settings.labels, {}),
    try(var.settings.labels, {})
  )

  storage_box_id = var.resources[
    try(var.settings.storage_box_lz_key, var.client_config.landingzone_key)
  ].storage_boxes[var.settings.storage_box_ref].id
}
