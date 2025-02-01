module "policy_definitions" {
  source = "./modules/policies/policy_definition"
  definitions_folder = "${path.cwd}/policies/definitions"
}

module "policy_assignments" {
  source            = "./modules/policies/policy_assignment"
  assignments_folder = "${path.cwd}/policies/assignments"
}
