variable "backend_type" {}
variable "tfstate" {}
variable "resource_group_name" {}
variable "storage_account_name" {}
variable "container_name" {}
variable "client_id" {}
variable "tenant_id" {}
variable "remote_state_subscription_id" {}

data "terraform_remote_state" "this" {
  backend = var.backend_type

  config = {
    resource_group_name  = var.resource_group_name
    storage_account_name = var.storage_account_name
    container_name       = var.container_name
    use_oidc             = true
    key                  = var.tfstate
    client_id            = var.client_id
    tenant_id            = var.tenant_id
    subscription_id      = var.remote_state_subscription_id
  }
}

output "outputs" {
  value = data.terraform_remote_state.this.outputs
}
