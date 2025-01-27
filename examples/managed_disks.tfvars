managed_disks = {
 disk1 = {
  name = "mg-test-01"
  resource_group_ref = "rg_test"
  create_option = "Empty"
  disk_size_gb = "20"
 }
}

resource_groups = {
  rg_test = {
    name     = "rg-test-dv-ne-01"
    location = "northeurope"
  }
}
