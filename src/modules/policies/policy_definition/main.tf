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

resource "null_resource" "main_subscription_policies_file" {
  triggers = {
    resource_type = local.main_subscription_policies_file
  }
}


resource "null_resource" "policy_definitions_folder" {
  triggers = {
    resource_type = local.policy_definitions_folder
  }
}

resource "null_resource" "main_subscription_policies" {
  triggers = {
    resource_type = jsonencode(local.main_subscription_policies) # Convert to JSON string
  }
}

resource "null_resource" "policy_definitions_to_create" {
  triggers = {
    resource_type = jsonencode(local.policy_definitions_to_create) # Convert to JSON string
  }
}

resource "null_resource" "should_create_policies" {
  triggers = {
    resource_type = local.should_create_policies
  }
}

resource "null_resource" "debug_file_existence" {
  triggers = {
    file_exists = tostring(fileexists(local.main_subscription_policies_file))
  }
}

resource "null_resource" "debug_policy_definitions_to_create" {
  triggers = {
    extracted_policies = jsonencode(local.policy_definitions_to_create)
  }
}

resource "null_resource" "debug_landing_zones" {
  triggers = {
    landing_zones_data = jsonencode(try(local.main_subscription_policies["landing-zones"], {}))
  }
}
