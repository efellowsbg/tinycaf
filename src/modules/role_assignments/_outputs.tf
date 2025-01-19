resource "null_resource" "debug" {
  triggers = {
    resource_type = jsonencode(var.settings)
  }
}
