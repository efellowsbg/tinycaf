# Firewall Attachment Module

Manages an hcloud_firewall_attachment resource.

## Usage

```hcl
firewall_attachments = {
  fwa_web = {
    firewall_ref   = "fw_web"
    server_ids_ref = ["srv_web_01", "srv_web_02"]
  }
}
```

## Inputs

| Name | Description | Required |
|------|-------------|----------|
| firewall_ref | Reference key to the firewall | Yes |
| server_ids_ref | List of server reference keys | No |
| label_selectors | List of label selectors | No |
