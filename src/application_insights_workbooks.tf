module "application_insights_workbooks" {
  source   = "./modules/application_insights_workbook"
  for_each = var.application_insights_workbooks

  settings        = each.value
  global_settings = local.global_settings

  resources = {
    resource_groups    = module.resource_groups
    managed_identities = module.managed_identities
  }
}
