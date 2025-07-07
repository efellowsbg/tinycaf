locals {


  subnet_id = try(
    var.resources[
      try(var.settings.subnet_lz_key, var.client_config.landingzone_key)
      ].virtual_networks[
      split("/", var.settings.subnet_ref)[0]
      ].subnets[
      split("/", var.settings.subnet_ref)[1]
    ].id,
    var.settings.subnet_id
  )
}
