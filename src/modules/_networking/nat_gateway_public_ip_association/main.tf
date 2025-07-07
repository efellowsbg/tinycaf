resource "azurerm_nat_gateway_public_ip_association" "main" {

  nat_gateway_id = try(var.resources[
    try(var.settings.nat_lz_key, var.client_config.landingzone_key)
  ].nat_gateways[var.settings.nat_gateway_ref].id, var.settings.nat_gateway_id)
  public_ip_address_id = try(var.resources[
    try(var.settings.ip_lz_key, var.client_config.landingzone_key)
  ].public_ips[var.settings.public_ip_ref].id, var.settings.public_ip_id)
}
