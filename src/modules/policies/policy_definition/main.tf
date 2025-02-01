variable "definitions_folder" {
  description = "Path to the policy definitions JSON files"
  type        = string
}

locals {
  main_subscription_policies_file = "${path.cwd}/main_subscription_policies.json"
  main_subscription_policies      = fileexists(local.main_subscription_policies_file) ? jsondecode(file(local.main_subscription_policies_file)) : {}
  policy_definitions_folder       = fileexists(local.main_subscription_policies_file) ? var.definitions_folder : ""
  policy_definitions_files        = fileset(local.policy_definitions_folder, "*.json")

  policy_definitions_map = {
    for file in local.policy_definitions_files :
    try(jsondecode(file("${local.policy_definitions_folder}/${file}"))["name"], file) => file
  }

  policy_definitions_to_create = {
    for policy in try(local.main_subscription_policies["landing-zones"]["policy_definitions"], []) :
    policy => lookup(local.policy_definitions_map, policy, null)
    if lookup(local.policy_definitions_map, policy, null) != null
  }

  should_create_policies = fileexists(local.main_subscription_policies_file) && length(local.policy_definitions_to_create) > 0
}

resource "azurerm_policy_definition" "policy" {
  for_each = local.policy_definitions_to_create

  name         = each.key
  policy_type  = "Custom"
  mode         = "All"

  display_name = try(jsondecode(file("${local.policy_definitions_folder}/${each.value}"))["properties"]["displayName"], "")
  policy_rule  = jsonencode(try(jsondecode(file("${local.policy_definitions_folder}/${each.value}"))["properties"]["policyRule"], {}))
  metadata     = jsonencode(try(jsondecode(file("${local.policy_definitions_folder}/${each.value}"))["properties"]["metadata"], {}))
  parameters   = jsonencode(try(jsondecode(file("${local.policy_definitions_folder}/${each.value}"))["properties"]["parameters"], {}))
}

output "policy_definitions_created" {
  value = local.should_create_policies ? azurerm_policy_definition.policy : {}
}
