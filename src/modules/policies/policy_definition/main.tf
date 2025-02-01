variable "definitions_folder" {
  description = "Path to the policy definitions JSON files"
  type        = string
}

locals {
  main_subscription_policies_file = "${path.cwd}/main_subscription_policies.json"
  main_subscription_policies      = fileexists(local.main_subscription_policies_file) ? jsondecode(file(local.main_subscription_policies_file)) : {}
  policy_definitions_folder       = fileexists(local.main_subscription_policies_file) ? var.definitions_folder : ""
  policy_definitions_to_create    = try(lookup(local.main_subscription_policies, "landing-zones", {})["policy_definitions"], [])
  should_create_policies          = fileexists(local.main_subscription_policies_file) && length(local.policy_definitions_to_create) > 0
}

resource "azurerm_policy_definition" "policy" {
  for_each = local.should_create_policies ? toset(local.policy_definitions_to_create) : toset([])

  name         = each.value
  policy_type  = "Custom"
  mode         = "All"

  display_name = try(jsondecode(file("${local.policy_definitions_folder}/${each.value}.json"))["properties"]["displayName"], "")
  policy_rule  = try(jsondecode(file("${local.policy_definitions_folder}/${each.value}.json"))["properties"]["policyRule"], {})
  metadata     = try(jsondecode(file("${local.policy_definitions_folder}/${each.value}.json"))["properties"]["metadata"], {})
}

output "policy_definitions_created" {
  value = local.should_create_policies ? azurerm_policy_definition.policy : {}
}


resource "null_resource" "print_path" {
  provisioner "local-exec" {
    command = "echo Terraform is running in: ${path.cwd}"
  }
}

resource "null_resource" "debug" {
  triggers = {
    resource_type = local.main_subscription_policies_file
  }
}
