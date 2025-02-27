local_network_gateways = {
  lng_test = {
    name               = "lng-test-dv-ne-01"
    resource_group_ref = "rg_test"
    gateway_address    = "12.13.14.15"
    cidr               = ["10.0.0.0/16"]
  }
}

# pre-requisites
resource_groups = {
  rg_test = {
    name     = "rg-test-dv-ne-01"
    location = "northeurope"
  }
}
