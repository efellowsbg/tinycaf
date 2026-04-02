# Hetzner Cloud CAF - tinycaf

Hetzner Cloud Adoption Framework modules for tinycaf. This is a parallel implementation to the Azure CAF modules in `src/`, fully independent and isolated.

## Why separate from `src/`?

`src/` is reserved for Azure CAF resources. The Hetzner implementation lives under `hertzner/` to maintain clean separation between cloud providers while sharing the same CAF philosophy and patterns.

## Architecture

```
hertzner/
├── _provider.tf              # hcloud provider configuration
├── _variables.tf             # Core variables (token, global_settings, landingzone)
├── _variables.resources.tf   # Resource type variable declarations
├── _locals.tf                # Global settings merge
├── _outputs.tf               # All module outputs
├── *.tf                      # Root composition files (one per resource group)
├── modules/                  # Reusable CAF modules
│   ├── network/
│   ├── server/
│   ├── firewall/
│   ├── load_balancer/
│   └── ...
└── examples/                 # Example .tfvars files
```

## Provider Authentication

Set the Hetzner Cloud API token via environment variable:

```bash
export HCLOUD_TOKEN="your-api-token"
```

Or pass it explicitly:

```hcl
hcloud_token = "your-api-token"
```

## Supported Modules

### Networking
| Module | Resource | Labels |
|--------|----------|--------|
| `network` | `hcloud_network` | Yes |
| `network_subnet` | `hcloud_network_subnet` | No |
| `network_route` | `hcloud_network_route` | No |

### Compute
| Module | Resource | Labels |
|--------|----------|--------|
| `server` | `hcloud_server` | Yes |
| `server_network` | `hcloud_server_network` | No |
| `placement_group` | `hcloud_placement_group` | Yes |

### Storage
| Module | Resource | Labels |
|--------|----------|--------|
| `volume` | `hcloud_volume` | Yes |
| `volume_attachment` | `hcloud_volume_attachment` | No |
| `snapshot` | `hcloud_snapshot` | Yes |
| `storage_box` | `hcloud_storage_box` | Yes |
| `storage_box_snapshot` | `hcloud_storage_box_snapshot` | Yes |
| `storage_box_subaccount` | `hcloud_storage_box_subaccount` | Yes |

### Security
| Module | Resource | Labels |
|--------|----------|--------|
| `firewall` | `hcloud_firewall` | Yes |
| `firewall_attachment` | `hcloud_firewall_attachment` | No |
| `ssh_key` | `hcloud_ssh_key` | Yes |

### IP Management
| Module | Resource | Labels |
|--------|----------|--------|
| `primary_ip` | `hcloud_primary_ip` | Yes |
| `floating_ip` | `hcloud_floating_ip` | Yes |
| `floating_ip_assignment` | `hcloud_floating_ip_assignment` | No |
| `rdns` | `hcloud_rdns` | No |

### Load Balancing
| Module | Resource | Labels |
|--------|----------|--------|
| `load_balancer` | `hcloud_load_balancer` | Yes |
| `load_balancer_service` | `hcloud_load_balancer_service` | No |
| `load_balancer_target` | `hcloud_load_balancer_target` | No |
| `load_balancer_network` | `hcloud_load_balancer_network` | No |

### Certificates
| Module | Resource | Labels |
|--------|----------|--------|
| `managed_certificate` | `hcloud_managed_certificate` | Yes |
| `uploaded_certificate` | `hcloud_uploaded_certificate` | Yes |

### DNS
| Module | Resource | Labels |
|--------|----------|--------|
| `zone` | `hcloud_zone` | Yes |
| `zone_record` | `hcloud_zone_record` | No |
| `zone_rrset` | `hcloud_zone_rrset` | Yes |

## Usage

Deploy using tfvars files (same as Azure CAF):

```bash
terraform init
terraform plan -var-file=examples/complete-foundation.tfvars
terraform apply -var-file=examples/complete-foundation.tfvars
```

## Labels Strategy

Labels are merged in two layers:
1. **Global labels** from `global_settings.labels`
2. **Resource-specific labels** from each resource's `labels` field

Resource-specific labels override global labels for the same key.

## Cross-Module References

Resources reference each other using `_ref` keys:

```hcl
network_subnets = {
  subnet_web = {
    network_ref  = "net_main"   # references networks.net_main
    type         = "cloud"
    ip_range     = "10.0.1.0/24"
    network_zone = "eu-central"
  }
}
```

For cross-landing-zone references, use `_lz_key`:

```hcl
network_subnets = {
  subnet_web = {
    network_ref    = "net_main"
    network_lz_key = "other_landingzone"
    # ...
  }
}
```

## Key Differences from Azure CAF

| Aspect | Azure CAF (`src/`) | Hetzner CAF (`hertzner/`) |
|--------|-------------------|--------------------------|
| Provider | azurerm, azapi | hcloud |
| Auth | OIDC (client_id, tenant_id) | API token (HCLOUD_TOKEN) |
| Resource grouping | Resource groups | None (flat per-project) |
| Metadata | Tags | Labels |
| Tag inheritance | Global → RG → resource | Global → resource |
| Regions | Azure regions | Hetzner locations (fsn1, nbg1, hel1, ash, hil, sin) |

## Not Included and Why

| Provider Resource | Reason |
|-------------------|--------|
| `hcloud_certificate` | Deprecated alias for `hcloud_uploaded_certificate` |
| `hcloud_server_poweroff` | Imperative action resource, not declarative infrastructure |
| `hcloud_server_poweron` | Imperative action resource, not declarative infrastructure |
| `hcloud_server_reboot` | Imperative action resource, not declarative infrastructure |
| `hcloud_server_reset` | Imperative action resource, not declarative infrastructure |

## Known Limitations

- No remote state pattern implemented yet (can be added following the Azure CAF pattern with `module.remote_states`)
- Landing zone cross-references work within the same state; multi-state references require the remote state pattern
- Provider version pinned to 1.60.1; update in `_provider.tf` as needed
