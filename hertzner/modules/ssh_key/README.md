# SSH Key Module

Manages an hcloud_ssh_key resource.

## Usage

```hcl
ssh_keys = {
  key_deploy = {
    name       = "deploy-key"
    public_key = file("~/.ssh/id_rsa.pub")
  }
}
```

## Inputs

| Name | Description | Required |
|------|-------------|----------|
| name | SSH key name | Yes |
| public_key | Public key content | Yes |
| labels | Key-value label pairs | No |
