locals {
  owners = toset(var.global_settings.object_id)
  tags = try(toset(merge(
    var.global_settings.tags,
    try(var.settings.tags, {})
  )), [])
}
