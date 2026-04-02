output "id" {
  value = hcloud_uploaded_certificate.main.id
}

output "name" {
  value = hcloud_uploaded_certificate.main.name
}

output "certificate" {
  value     = hcloud_uploaded_certificate.main.certificate
  sensitive = true
}

output "domain_names" {
  value = hcloud_uploaded_certificate.main.domain_names
}

output "fingerprint" {
  value = hcloud_uploaded_certificate.main.fingerprint
}

output "created" {
  value = hcloud_uploaded_certificate.main.created
}

output "not_valid_before" {
  value = hcloud_uploaded_certificate.main.not_valid_before
}

output "not_valid_after" {
  value = hcloud_uploaded_certificate.main.not_valid_after
}

output "labels" {
  value = hcloud_uploaded_certificate.main.labels
}
