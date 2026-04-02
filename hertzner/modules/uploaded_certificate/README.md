# Uploaded Certificate Module

Manages an hcloud_uploaded_certificate resource.

## Usage

```hcl
uploaded_certificates = {
  cert_custom = {
    name        = "cert-custom"
    private_key = file("certs/private.key")
    certificate = file("certs/cert.pem")
  }
}
```

## Inputs

| Name | Description | Required |
|------|-------------|----------|
| name | Certificate name | Yes |
| private_key | Private key PEM content (sensitive) | Yes |
| certificate | Certificate PEM content | Yes |
| labels | Key-value label pairs | No |
