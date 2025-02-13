application_insights_workbooks = {
  test_workbook1 = {
    resource_group_ref = "rg_test"
    display_name       = "workbook1"
    data_json = {
      "version" = "Notebook/1.0",
      "items" = [
        {
          "type" = "1",
          "content" = {
            "json" = "Test2024"
          },
          "name" = "text - 0"
        }
      ],
      "isLocked" = false,
      "fallbackResourceIds" = [
        "Azure Monitor"
      ]
    }
  }

  test_workbook2 = {
    resource_group_ref = "rg_test"
    display_name       = "workbook2"
    data_json = {
      "version" = "Notebook/1.0",
      "items" = [
        {
          "type" = "2",
          "content" = {
            "json" = "Test2025"
          },
          "name" = "text - 0"
        }
      ],
      "isLocked" = false,
      "fallbackResourceIds" = [
        "Azure Monitor"
      ]
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
