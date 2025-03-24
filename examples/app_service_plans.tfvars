app_service_plans = {
  asp1 = {
    name               = "asp-ivan-01"
    resource_group_ref = "rg_test"
    is_xenon           = true
    sku = {
      tier = "Standard"
      size = "S1"
    }
  }
  asp2 = {
    name               = "asp-ivan-02"
    resource_group_ref = "rg_test"
    is_xenon           = false
    sku = {
      tier = "Standard"
      size = "S1"
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