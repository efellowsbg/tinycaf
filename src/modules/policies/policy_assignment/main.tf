variable "assignments_folder" {
  description = "Path to the policy assignments JSON files"
  type        = string
}

# Fetch the current subscription ID
data "azurerm_client_config" "current" {}

locals {
  main_subscription_policies_file = "${path.cwd}/main_subscription_policies.json"
  main_subscription_policies      = fileexists(local.main_subscription_policies_file) ? jsondecode(file(local.main_subscription_policies_file)) : {}
  policy_assignments_files = fileset(var.assignments_folder, "*.json")

  policy_assignments_map = {
    for file in local.policy_assignments_files :
    try(jsondecode(file("${var.assignments_folder}/${file}"))["name"], file) => file
  }

  policy_assignments_to_create = {
    for assignment in try(local.main_subscription_policies["landing-zones"]["policy_assignments"], []) :
    assignment => lookup(local.policy_assignments_map, assignment, null)
    if lookup(local.policy_assignments_map, assignment, null) != null
  }
}

resource "azurerm_resource_policy_assignment" "main" {
  for_each = local.policy_assignments_to_create
  name                 = each.key
  display_name         = try(jsondecode(file("${var.assignments_folder}/${each.value}"))["properties"]["displayName"], "")
  description          = try(jsondecode(file("${var.assignments_folder}/${each.value}"))["properties"]["description"], "")
  policy_definition_id = replace(try(jsondecode(file("${var.assignments_folder}/${each.value}"))["properties"]["policyDefinitionId"], ""), "${current_scope_resource_id}", "/subscriptions/${data.azurerm_client_config.current.subscription_id}")
  resource_id               = replace(try(jsondecode(file("${var.assignments_folder}/${each.value}"))["properties"]["scope"], ""), "${current_scope_resource_id}", "/subscriptions/${data.azurerm_client_config.current.subscription_id}")
  location            = try(jsondecode(file("${var.assignments_folder}/${each.value}"))["location"], "")
  identity { type = try(jsondecode(file("${var.assignments_folder}/${each.value}"))["identity"]["type"], "SystemAssigned") }
  parameters = jsonencode(try(jsondecode(file("${var.assignments_folder}/${each.value}"))["properties"]["parameters"], {}))
}
