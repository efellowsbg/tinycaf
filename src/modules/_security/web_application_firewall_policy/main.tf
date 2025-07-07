resource "azurerm_web_application_firewall_policy" "main" {
  name                = var.settings.name
  resource_group_name = local.resource_group_name
  location            = local.location

  dynamic "policy_settings" {
    for_each = can(var.settings.policy_settings) ? [1] : []
    content {
      enabled                     = try(var.settings.policy_settings.enabled, true)
      mode                        = try(var.settings.policy_settings.mode, "Prevention")
      request_body_check          = try(var.settings.policy_settings.request_body_check, true)
      file_upload_limit_in_mb     = try(var.settings.policy_settings.file_upload_limit_in_mb, 100)
      max_request_body_size_in_kb = try(var.settings.policy_settings.max_request_body_size_in_kb, 128)

      request_body_enforcement                  = try(var.settings.policy_settings.request_body_enforcement, true)
      request_body_inspect_limit_in_kb          = try(var.settings.policy_settings.request_body_inspect_limit_in_kb, 128)
      js_challenge_cookie_expiration_in_minutes = try(var.settings.policy_settings.js_challenge_cookie_expiration_in_minutes, 60)
      file_upload_enforcement                   = try(var.settings.policy_settings.file_upload_enforcement, true)
    }
  }

  dynamic "custom_rules" {
    for_each = try(var.settings.custom_rules, {})
    content {
      name      = try(custom_rules.value.name, null)
      priority  = custom_rules.value.priority
      rule_type = custom_rules.value.rule_type
      action    = custom_rules.value.action

      dynamic "match_conditions" {
        for_each = try(custom_rules.value.match_conditions, [])
        content {
          operator           = match_conditions.value.operator
          match_values       = try(match_conditions.value.match_values, [])
          negation_condition = try(match_conditions.value.negation_condition, null)
          transforms         = try(match_conditions.value.transforms, [])

          dynamic "match_variables" {
            for_each = try(match_conditions.value.match_variables, [])
            content {
              variable_name = match_variables.value.variable_name
              selector      = try(match_variables.value.selector, null)
            }
          }
        }
      }
    }
  }


  dynamic "managed_rules" {
    for_each = can(var.settings.managed_rules) ? [1] : []
    content {
      dynamic "exclusion" {
        for_each = try(var.settings.managed_rules.exclusion, [])
        content {
          match_variable          = exclusion.value.match_variable
          selector                = exclusion.value.selector
          selector_match_operator = try(exclusion.value.selector_match_operator, "Equals")

          dynamic "excluded_rule_set" {
            for_each = try(exclusion.value.excluded_rule_set, [])
            content {
              type    = try(excluded_rule_set.value.type, null)
              version = try(excluded_rule_set.value.version, null)

              dynamic "rule_group" {
                for_each = try(excluded_rule_set.value.rule_group, [])
                content {
                  rule_group_name = rule_group.value.rule_group_name
                  excluded_rules  = try(rule_group.value.excluded_rules, [])
                }
              }
            }
          }
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
