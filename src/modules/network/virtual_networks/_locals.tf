locals {
  resource_group = var.resources.resource_groups[var.settings.resource_group_ref]
  resource_group_name = local.resource_group.name
  location = local.resource_group.location
  tags = local.resource_group.tags
}
