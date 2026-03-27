locals {
  resource_group = var.resources[
    try(var.settings.lz_key, var.client_config.landingzone_key)
  ].resource_groups[var.settings.resource_group_ref]

  automation_account_name = var.resources[
    try(var.settings.acc_lz_key, var.client_config.landingzone_key)
  ].automation_accounts[var.settings.acc_ref].name

  resource_group_name = local.resource_group.name
  location            = local.resource_group.location

  tags = merge(
    var.global_settings.tags,
    var.global_settings.inherit_resource_group_tags ? local.resource_group.tags : {},
    try(var.settings.tags, {})
  )

  # Resolve landing zone per job schedule
  job_lzkeys = {
    for js_key, js in try(var.settings.job_schedules, {}) :
    js_key => try(js.parameters.lzkey, var.client_config.landingzone_key)
  }

  # Resolve parameters
  job_schedule_parameters = {
    for js_key, js in try(var.settings.job_schedules, {}) :

    js_key => merge(
      # 1. Resolve all parameters (keep original keys)
      {
        for p_key, p_val in try(js.parameters, {}) :
        p_key => (
          # CASE 1: resolve reference if ends with _ref
          endswith(p_key, "_ref") && length(trimspace(p_val)) > 0 ?
          try(
            lookup(
              lookup(
                var.resources[local.job_lzkeys[js_key]],
                split("/", p_val)[0],
                {}
              ),
              split("/", p_val)[1],
              {}
            )[split("/", p_val)[2]],
            null
          )
          # CASE 2: direct value
          : p_val
        )
      },

      # 2. Always set subscription_id
      {
        subscription_id = try(js.parameters.subscription_id, var.global_settings.subscription_id)
      }
    )
  }
}
