resource "azurerm_policy_definition" "main" {
  for_each = toset(var.policy_definitions)

  name         = each.value
  policy_type  = "Custom"
  mode         = "All"
  display_name = jsondecode(file("${var.definitions_path}/${each.value}.json")).properties.displayName
  policy_rule  = jsonencode(jsondecode(file("${var.definitions_path}/${each.value}.json")).properties.policyRule)
  parameters   = jsonencode(jsondecode(file("${var.definitions_path}/${each.value}.json")).properties.parameters)
}
