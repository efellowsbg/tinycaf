resource "azurerm_web_application_firewall_policy" "this" {
  name                = var.settings.name
  resource_group_name = local.resource_group_name
  location            = local.location

  dynamic "policy_settings" {
    for_each = can(var.settings.identity) ? [1] : []
    content {
      enabled                     = try(var.settings.policy_settings.enabled, true)
      mode                        = try(var.settings.policy_settings.mode, "Prevention")
      request_body_check          = try(var.settings.policy_settings.request_body_check, true)
      max_request_body_size_kb    = try(var.settings.policy_settings.max_request_body_size_kb, 128)
      file_upload_limit_in_mb     = try(var.settings.policy_settings.file_upload_limit_in_mb, 100)
      max_request_body_size_in_kb = try(var.settings.policy_settings.max_request_body_size_in_kb, 128)
      dynamic "log_scrubbing" {
        for_each = try(var.settings.policy_settings.log_scrubbing, [])
        content {
          enabled = log_scrubbing.value.enabled
          rule    = log_scrubbing.value.rule
        }
      }
      request_body_enforcement                  = try(var.settings.policy_settings.request_body_enforcement, true)
      request_body_inspect_limit_in_kb          = try(var.settings.policy_settings.request_body_inspect_limit_in_kb, 128)
      js_challenge_cookie_expiration_in_minutes = try(var.settings.policy_settings.js_challenge_cookie_expiration_in_minutes, 60)
      file_upload_enforcement                   = try(var.settings.policy_settings.file_upload_enforcement, true)
    }
  }

  dynamic "custom_rules" {
    for_each = try(var.settings.custom_rules, [])
    content {
      name      = custom_rules.value.name
      priority  = custom_rules.value.priority
      rule_type = custom_rules.value.rule_type

      match_conditions {
        match_variables {
          variable_name = custom_rules.value.match_condition.variable_name
        }

        operator           = custom_rules.value.match_condition.operator
        negation_condition = try(custom_rules.value.match_condition.negation_condition, false)
        match_values       = custom_rules.value.match_condition.match_values
      }

      action = custom_rules.value.action
    }
  }

  dynamic "managed_rules" {
    for_each = can(var.settings.managed_rules) ? [1] : []
    content {
      dynamic "exclusions" {
        for_each = try(var.settings.managed_rules.exclusions, [])
        content {
          match_variable = exclusions.value.match_variable
          selector       = exclusions.value.selector
          operator       = exclusions.value.operator
        }
      }

      dynamic "managed_rule_set" {
        for_each = try(var.settings.managed_rules.managed_rule_set, [])
        content {
          type    = managed_rule_set.value.type
          version = managed_rule_set.value.version

          dynamic "rule_group_override" {
            for_each = try(managed_rule_set.value.rule_group_override, [])
            content {
              rule_group_name = rule_group_override.value.rule_group_name

              dynamic "rules" {
                for_each = try(rule_group_override.value.rules, [])
                content {
                  rule_id = rules.value.rule_id
                  action  = rules.value.action
                }
              }
            }
          }
        }
      }
    }
  }

  tags = local.tags
}
