azuread_groups = {
  test_group = {
    display_name     = "App-Admins"
    description      = "Administrators for the App platform"
    mail_enabled     = false
    security_enabled = true
    visibility       = "Private"
    tags = {
      environment = "test"
    }
  }
}
