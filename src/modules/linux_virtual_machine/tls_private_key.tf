resource "tls_private_key" "main" {
  algorithm = var.settings.public_key_openssh.test_key.algorithm
  rsa_bits  = var.settings.public_key_openssh.test_key.rsa_bits
}
