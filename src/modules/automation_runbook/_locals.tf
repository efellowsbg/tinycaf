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

  generated_job_schedules = merge(
    [
      for schedule_key, schedule_list in try(var.settings.schedule_map, {}) : {
        for schedule_ref in schedule_list :
        "${schedule_key}-${schedule_ref}" => {
          schedule_ref = schedule_ref
          parameters = merge(
            try(var.settings.default_job_parameters, {}),
            {
              for p_key, p_val in try(var.settings.dynamic_job_parameters, {}) :
              p_key => replace(p_val, "{schedule_key}", schedule_key)
            }
          )
        }
      }
    ]...
  )

  merged_job_schedules = merge(
    local.generated_job_schedules,
    try(var.settings.job_schedules, {})
  )

  job_lzkeys = {
    for js_key, js in local.merged_job_schedules :
    js_key => try(js.parameters.lzkey, var.client_config.landingzone_key)
  }

  job_schedule_parameters = {
    for js_key, js in local.merged_job_schedules :
    js_key => merge(
      {
        for p_key, p_val in try(js.parameters, {}) :
        p_key => (
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
          : p_val
        )
      },
      {
        subscription_id = try(js.parameters.subscription_id, var.global_settings.subscription_id)
      }
    )
  }
}
