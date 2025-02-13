nat_gateways = {
  nat_gateway_test1 = {
    name                    = "nat-gateway1"
    resource_group_ref      = "rg_test"
    sku_name                = "Standard"
    idle_timeout_in_minutes = "5"
    zones                   = ["1"]
  }

  nat_gateway_test2 = {
    name                    = "nat-gateway2"
    resource_group_ref      = "rg_test"
    sku_name                = "Standard"
    idle_timeout_in_minutes = "4"
    zones                   = ["2"]
  }
}

# pre-requisites
resource_groups = {
  rg_test = {
    name     = "rg-test-dv-ne-01"
    location = "northeurope"
  }
}
