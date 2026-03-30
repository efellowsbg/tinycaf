automation_runbooks = {
  test_runbook = {
    name                     = "runbooktest"
    acc_ref                  = "test_auto_acc"
    runbook_type             = "PowerShell"
    resource_group_ref       = "rg_test"
    log_progress             = true
    log_verbose              = true
    description              = "Daily cleanup of diagnostic logs older than 30 days."
    log_activity_trace_level = 9
    tags = {
      Env = "Test"
    }

    job_schedules = {
      daily = {
        schedule_ref = "daily_schedule"
        parameters = {
          RetentionDays = "30"
        }
      }

      weekly = {
        schedule_ref = "weekly_schedule"
        parameters = {
          RetentionDays = "90"
        }
      }
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
}

resource_groups = {
  rg_test = {
    name     = "rg-test-01"
    location = "northeurope"
    tags = {
    }
  }
}
