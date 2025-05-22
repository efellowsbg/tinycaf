variable "backend_type" {}
variable "tfstate" {}
variable "resource_group_name" {}
variable "storage_account_name" {}
variable "container_name" {}

data "terraform_remote_state" "this" {
  backend = var.backend_type

  config = {
    resource_group_name  = var.resource_group_name
    storage_account_name = var.storage_account_name
    container_name       = var.container_name
    key                  = var.tfstate
    use_oidc             = true
    use_azuread_auth     = true
  }
}

output "outputs" {
  value = data.terraform_remote_state.this.outputs
}
