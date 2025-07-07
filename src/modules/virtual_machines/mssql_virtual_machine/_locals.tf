locals {
  virtual_machine_id = try(
    var.resources[
      try(var.settings.lz_key, var.client_config.landingzone_key)
    ].windows_virtual_machines[var.settings.virtual_machine_ref].id,
    var.resources[
      try(var.settings.lz_key, var.client_config.landingzone_key)
    ].linux_virtual_machines[var.settings.virtual_machine_ref].id,
    var.settings.virtual_machine_id
  )


}
