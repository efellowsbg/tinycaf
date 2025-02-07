locals {
  owners = [var.global_settings.object_id]
  tags = merge(
    var.global_settings.tags,
    try(var.settings.tags, {})
  )
}
