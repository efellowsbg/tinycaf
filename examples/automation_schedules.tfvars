automation_schedules = {
  daily_schedule = {
    resource_group_ref = "rg_test"
    acc_ref            = "test_auto_acc"
    name               = "daily-midnight"
    frequency          = "Day"
    interval           = 1
    start_time         = "2025-11-14T00:00:00Z"
    expiry_time        = "2026-01-01T00:00:00Z"
    timezone           = "UTC"
    description        = "Daily schedule at midnight"
  }

  weekly_schedule = {
    resource_group_ref = "rg_test"
    acc_ref            = "test_auto_acc"
    name               = "weekly-monday"
    frequency          = "Week"
    interval           = 1
    week_days          = ["Monday"]
    start_time         = "2025-11-14T09:00:00Z"
    description        = "Runs every Monday at 9 AM UTC"
  }

  monthly_schedule = {
    resource_group_ref = "rg_test"
    acc_ref            = "test_auto_acc"
    name               = "monthly-first-monday"
    frequency          = "Month"
    interval           = 1
    start_time         = "2025-11-01T08:00:00Z"
    description        = "Runs the first Monday of every month"
    monthly_occurrence = {
      day        = "Monday"
      occurrence = 1
    }
  }
}

# pre-requisites
automation_accounts = {
  test_auto_acc = {
    name                          = "automation-account-test"
    resource_group_ref            = "rg_test"
    local_authentication_enabled  = true
    public_network_access_enabled = true
    tags = {
      Env = "Test"
    }
  }
}

resource_groups = {
  rg_test = {
    name     = "rg-test-01"
    location = "northeurope"
    tags = {
      DeployDate = "11/07/2025",
      DeadLine   = "11/07/2026",
      Owner      = "Test Test",
      Project    = "Test",
    }
  }
}
