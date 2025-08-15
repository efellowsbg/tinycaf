resource "tls_private_key" "main" {
  for_each = try(var.settings.public_key_openssh, {})

  algorithm = each.value.algorithm
  rsa_bits  = each.value.rsa_bits
}
