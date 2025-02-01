module "policy_definitions" {
  source = "./modules/policies/policy_definition"

  policy_definitions = jsondecode(file("${path.module}/main_subscription_policies.json")).landing-zones.policy_definitions
  definitions_path  = "${path.module}/policies"
}
