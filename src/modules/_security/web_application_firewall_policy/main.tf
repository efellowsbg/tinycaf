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
      file_upload_limit_in_mb     = try(var.settings.policy_settings.file_upload_limit_in_mb, 100)
      max_request_body_size_in_kb = try(var.settings.policy_settings.max_request_body_size_in_kb, 128)
      dynamic "log_scrubbing" {
        for_each = try(var.settings.policy_settings.log_scrubbing, [])
        content {
          enabled = log_scrubbing.value.enabled
          dynamic "scrubbing_rule" {
            for_each = try(log_scrubbing.value.scrubbing_rule, [])
            content {
              enabled                 = try(scrubbing_rule.value.enabled, true)
              match_variable          = scrubbing_rule.value.match_variable
              selector                = try(scrubbing_rule.value.selector, null)
              selector_match_operator = try(scrubbing_rule.value.selector_match_operator, "Equals")
            }
          }
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
      dynamic "exclusion" {
        for_each = try(var.settings.managed_rules.exclusions, [])
        content {
          match_variable          = exclusion.value.match_variable
          selector                = exclusion.value.selector
          selector_match_operator = try(exclusion.value.selector_match_operator, "Equals")
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

              dynamic "rule" {
                for_each = try(rule_group_override.value.rules, [])
                content {
                  id      = rule.value.id
                  action  = try(rule.value.action, null)
                  enabled = try(rule.value.enabled, false)
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
