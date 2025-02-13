resource "azurerm_subnet_network_security_group_association" "main" {
  for_each = { for k, v in var.settings.subnets : k => v if can(v.network_security_group_ref) }

  subnet_id                 = local.subnet_ids[each.key]
  network_security_group_id = local.network_security_group_ids[each.key]
}
