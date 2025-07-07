managed_identities = {
  id_test = {
    name               = "id-test-dv-ne-01"
    resource_group_ref = "rg_test"
  }
}

# pre-requisites
resource_groups = {
  rg_test = {
    name     = "rg-test-dv-ne-01"
    location = "northeurope"
  }
}
