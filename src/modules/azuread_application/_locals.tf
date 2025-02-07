locals {
  tags = try(toset(merge(
    var.global_settings.tags,
    try(var.settings.tags, {})
  )), [])
}
