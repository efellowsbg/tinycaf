role_definitions = {
  test_role1 = {
    name      = "test-role1"
    scope_ref = "rg_test" #The value of scope_ref must be reference to a resource or the Id of the resource

    permissions = {
      actions     = ["*"]
      not_actions = []
    }
  }
}

# pre-requisites
resource_groups = {
  rg_test = {
    name     = "rg-test-dv-ne-01"
    location = "northeurope"
  }
}
