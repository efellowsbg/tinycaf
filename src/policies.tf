module "policy_definitions" {
  source = "./modules/policies/policy_definition"
  definitions_folder = "${path.cwd}/policies/definitions"
}
