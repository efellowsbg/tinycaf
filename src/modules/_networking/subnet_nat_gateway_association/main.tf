resource "azurerm_subnet_nat_gateway_association" "main" {

  nat_gateway_id = try(var.resources[
    try(var.settings.nat_lz_key, var.client_config.landingzone_key)
  ].nat_gateways[var.settings.nat_gateway_ref].id, var.settings.nat_gateway_id)
  subnet_id = local.subnet_id
}
