variable "definitions_folder" {
  description = "Path to the policy definitions JSON files"
  type        = string
}

locals {
  main_subscription_policies_file = "${path.cwd}/main_subscription_policies.json"
  main_subscription_policies      = fileexists(local.main_subscription_policies_file) ? jsondecode(file(local.main_subscription_policies_file)) : {}
  policy_definitions_folder       = fileexists(local.main_subscription_policies_file) ? var.definitions_folder : ""
}
locals {

  # Ensure "landing-zones" exists before accessing "policy_definitions"
  landing_zones = try(local.main_subscription_policies["landing-zones"], {})

  # Correctly extract the policy definitions as a list
  policy_definitions_to_create    = try(local.landing_zones.policy_definitions, [])

  should_create_policies          = fileexists(local.main_subscription_policies_file) && length(local.policy_definitions_to_create) > 0
}

resource "azurerm_policy_definition" "policy" {
  for_each = local.should_create_policies ? toset(local.policy_definitions_to_create) : toset([])

  name         = each.value
  policy_type  = "Custom"
  mode         = "All"

  display_name = try(jsondecode(file("${local.policy_definitions_folder}/${each.value}.json"))["properties"]["displayName"], "")
  policy_rule  = jsonencode(try(jsondecode(file("${local.policy_definitions_folder}/${each.value}.json"))["properties"]["policyRule"], {}))
  metadata     = jsonencode(try(jsondecode(file("${local.policy_definitions_folder}/${each.value}.json"))["properties"]["metadata"], {}))
  parameters   = jsonencode(try(jsondecode(file("${local.policy_definitions_folder}/${each.value}.json"))["properties"]["parameters"], {}))
}

output "policy_definitions_created" {
  value = local.should_create_policies ? azurerm_policy_definition.policy : {}
}
