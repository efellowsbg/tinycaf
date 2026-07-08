# Reverse DNS Module

Manages an hcloud_rdns resource.

## Usage

```hcl
rdns_records = {
  rdns_web = {
    dns_ptr    = "web.example.com"
    ip_address = "1.2.3.4"
    server_ref = "srv_web_01"
  }
}
```

## Inputs

| Name | Description | Required |
|------|-------------|----------|
| dns_ptr | DNS pointer (hostname) | Yes |
| ip_address | IP address for rDNS | Yes |
| server_ref | Reference to server (mutually exclusive with others) | No |
| primary_ip_ref | Reference to primary IP | No |
| floating_ip_ref | Reference to floating IP | No |
| load_balancer_ref | Reference to load balancer | No |
