locals {
  remote_objects            = { for state_ref, remote in data.terraform_remote_state.remote : state_ref => remote.outputs.objects }
  remote_resource_groups    = { for state_ref, remote in local.remote_objects : state_ref => remote.resource_groups }
  remote_managed_identities = { for state_ref, remote in local.remote_objects : state_ref => remote.managed_identities }
  remote_users              = { for state_ref, remote in local.remote_objects : state_ref => remote.users }
}
