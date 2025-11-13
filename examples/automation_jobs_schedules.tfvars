automation_jobs_schedules = {
  test_job = {
    resource_group_ref = "rg_test"
    acc_ref            = "test_auto_acc"
    runbook_ref        = "test_runbook"
    schedule_ref       = "daily_schedule"
    run_on             = "HybridWorkerGroup01"

    parameters = {
      server_name = "servertest"
      restart     = "false"
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

    draft = {
      edit_mode_enabled = true
      output_types      = ["string"]

      content_link = {
        uri     = "https://raw.githubusercontent.com/org/repo/dev/runbooks/cleanup.ps1"
        version = "0.9.0"

        hash = {
          algorithm = "SHA256"
          value     = "B32E61E3D26D9C94D2AAFF5735C542A829E94C6C7BBCE83B7298C11B9F678ABC"
        }
      }

      parameters = {
        param_01 = {
          key           = "RetentionDays"
          type          = "Int"
          mandatory     = true
          position      = 1
          default_value = "30"
        }
        param_02 = {
          key           = "storageaccount"
          type          = "String"
          mandatory     = false
          position      = 2
          default_value = "mystorageacct"
        }
      }
    }
    publish_content_link = {
      uri     = "https://raw.githubusercontent.com/org/repo/main/runbooks/cleanup.ps1"
      version = "1.0.0"

      hash = {
        algorithm = "SHA256"
        value     = "C67F36DDA2AC0AAE7B44B69B7AA7BB22113E6543E0AD91A9A6DA27676B8D5A62"
      }
    }
    job_schedules = {
      daily = {
        schedule_name = "Dailymidnight"
        parameters = {
          RetentionDays = "30"
        }
      }

      weekly = {
        schedule_name = "weeklyreport"
        parameters = {
          RetentionDays  = "90"
          StorageAccount = "archivestorageacct"
        }
      }
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
