resource "azurerm_network_interface" "main" {
  for_each            = var.settings.network_interfaces
  name                = each.value.name
  resource_group_name = local.resource_group_name
  location            = local.location

  tags = local.tags

  ip_configuration {
    name = each.value.ip_configuration.name
    subnet_id = try(
      var.resources[
        try(each.value.ip_configuration.subnet_lz_key, var.client_config.landingzone_key)
        ].virtual_networks[
        split("/", each.value.ip_configuration.subnet_ref)[0]
        ].subnets[
        split("/", each.value.ip_configuration.subnet_ref)[1]
      ].id,
      null
    )

    private_ip_address_allocation = try(each.value.ip_configuration.private_ip_address_allocation, "Dynamic")
    private_ip_address = try(
      each.value.ip_configuration.private_ip_address_allocation == "Static" ? each.value.ip_configuration.private_ip_address : null,
      null
    )
    public_ip_address_id = try(
      var.resources[
        try(each.value.ip_configuration.public_ip_lz_key, var.client_config.landingzone_key)
        ].public_ips[
        each.value.ip_configuration.public_ip_ref
      ].id,
      null
    )
  }
}


resource "azurerm_network_interface_security_group_association" "main" {
  for_each = {
    for key, val in var.settings.network_interfaces :
    key => val if try(val.network_security_group_ref, null) != null && try(val.network_security_group_ref, "") != ""
  }

  network_interface_id = azurerm_network_interface.main[each.key].id

  network_security_group_id = var.resources[
    try(each.value.network_security_group_lz_key, var.client_config.landingzone_key)
  ].network_security_groups[
    each.value.network_security_group_ref
  ].id
}