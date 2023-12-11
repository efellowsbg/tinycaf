locals {
  all_resource_groups    = merge({ (local.ref) = local.local_resource_groups }, local.remote_resource_groups)
  all_managed_identities = merge({ (local.ref) = local.local_managed_identities }, local.remote_managed_identities)
  all_users              = merge({ (local.ref) = local.local_users }, local.remote_users)
}
