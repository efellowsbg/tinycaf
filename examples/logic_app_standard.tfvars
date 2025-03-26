logic_apps_standard = {
  lapp1 = {
    name                 = "example-logic-app"
    resource_group_ref   = "rg_test"
    app_service_plan_ref = "asp1"
    storage_account_ref  = "st_test"

    app_settings = {
      "FUNCTIONS_WORKER_RUNTIME"     = "node"
      "WEBSITE_NODE_DEFAULT_VERSION" = "~18"
    }

    site_config = {
      always_on = true
      cors = {
        allowed_origins = ["*"]
      }
    }
  }
}
