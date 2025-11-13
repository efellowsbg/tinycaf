resource "azurerm_automation_runbook" "main" {
  name                     = var.settings.name
  runbook_type             = var.settings.runbook_type
  log_progress             = var.settings.log_progress
  log_verbose              = var.settings.log_verbose
  resource_group_name      = try(local.resource_group_name, var.settings.resource_group_name)
  location                 = try(local.location, var.settings.location)
  automation_account_name  = try(local.automation_account_name, var.settings.automation_account_name)
  tags                     = local.tags
  description              = try(var.settings.description, null)
  content                  = try(var.settings.content, null)
  log_activity_trace_level = try(var.settings.log_activity_trace_level, null)

  dynamic "publish_content_link" {
    for_each = can(var.settings.publish_content_link) ? [1] : []
    content {
      uri     = var.settings.publish_content_link.uri
      version = try(var.settings.publish_content_link.version, null)

      dynamic "hash" {
        for_each = can(var.settings.publish_content_link.hash) ? [1] : []
        content {
          algorithm = var.settings.publish_content_link.hash.algorithm
          value     = var.settings.publish_content_link.hash.value
        }
      }
    }
  }

  dynamic "draft" {
    for_each = can(var.settings.draft) ? [1] : []
    content {
      edit_mode_enabled = try(var.settings.draft.edit_mode_enabled, null)
      output_types      = try(var.settings.draft.output_types, null)

      dynamic "content_link" {
        for_each = can(var.settings.draft.content_link) ? [1] : []
        content {
          uri     = var.settings.draft.content_link.uri
          version = try(var.settings.draft.content_link.version, null)

          dynamic "hash" {
            for_each = can(var.settings.draft.content_link.hash) ? [1] : []
            content {
              algorithm = var.settings.draft.content_link.hash.algorithm
              value     = var.settings.draft.content_link.hash.value
            }
          }
        }
      }

      dynamic "parameters" {
        for_each = try(var.settings.draft.parameters, [])
        content {
          key           = lower(parameters.value.key)
          type          = parameters.value.type
          mandatory     = try(parameters.value.mandatory, null)
          position      = try(parameters.value.position, null)
          default_value = try(parameters.value.default_value, null)
        }
      }
    }
  }

  dynamic "job_schedule" {
    for_each = try(var.settings.job_schedules, {})
    content {
      schedule_name = job_schedule.value.schedule_name
      parameters    = try(job_schedule.value.parameters, null)
      run_on        = try(job_schedule.value.run_on, null)
    }
  }
}
