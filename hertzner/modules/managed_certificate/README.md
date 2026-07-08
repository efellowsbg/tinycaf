# Managed Certificate Module

Manages an hcloud_managed_certificate resource (Let's Encrypt).

## Usage

```hcl
managed_certificates = {
  cert_web = {
    name         = "cert-web"
    domain_names = ["example.com", "www.example.com"]
  }
}
```

## Inputs

| Name | Description | Required |
|------|-------------|----------|
| name | Certificate name | Yes |
| domain_names | List of domain names | Yes |
| labels | Key-value label pairs | No |
