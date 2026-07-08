# Volume Attachment Module

Manages an hcloud_volume_attachment resource.

## Usage

```hcl
volume_attachments = {
  va_data = {
    volume_ref = "vol_data"
    server_ref = "srv_web_01"
    automount  = true
  }
}
```

## Inputs

| Name | Description | Required |
|------|-------------|----------|
| volume_ref | Reference key to the volume | Yes |
| server_ref | Reference key to the server | Yes |
| automount | Auto-mount the volume | No |
