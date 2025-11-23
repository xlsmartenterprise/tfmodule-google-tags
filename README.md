# tfmodule-google-tags

Terraform module for managing GCP Tag Keys and Tag Values for resource organization and firewall policy integration.

## Features

- Create tag keys at organization or project level
- Support for multiple tag values under a single tag key
- GCE_FIREWALL purpose support for firewall policy integration
- Purpose data configuration for network-specific firewall tags
- Flexible parent resource configuration (organization or project)
- Comprehensive outputs for tag management
- Input validation for purpose field

## Usage

### Basic Example

```hcl
module "tags" {
  source = "github.com/your-org/tfmodule-google-tags?ref=v1.0.0"

  parent       = "organizations/123456789"
  tag_key_name = "environment"

  tag_values = {
    production = {}
    staging    = {}
    development = {}
  }
}
```

### Firewall Policy Integration Example

```hcl
module "firewall_tags" {
  source = "github.com/your-org/tfmodule-google-tags?ref=v1.0.0"

  parent       = "organizations/123456789"
  tag_key_name = "security-zone"
  purpose      = "GCE_FIREWALL"

  purpose_data = {
    network = "projects/my-project/global/networks/vpc-network"
  }

  tag_values = {
    dmz      = {}
    internal = {}
    secure   = {}
  }
}
```

### Project-Level Tags Example

```hcl
module "project_tags" {
  source = "github.com/your-org/tfmodule-google-tags?ref=v1.0.0"

  parent       = "projects/my-project-id"
  tag_key_name = "cost-center"

  tag_values = {
    engineering = {}
    marketing   = {}
    sales       = {}
    operations  = {}
  }
}
```

### Multiple Tag Keys Example

```hcl
# Environment tags
module "environment_tags" {
  source = "github.com/your-org/tfmodule-google-tags?ref=v1.0.0"

  parent       = "organizations/123456789"
  tag_key_name = "environment"

  tag_values = {
    prod = {}
    dev  = {}
  }
}

# Application tags
module "application_tags" {
  source = "github.com/your-org/tfmodule-google-tags?ref=v1.0.0"

  parent       = "organizations/123456789"
  tag_key_name = "application"

  tag_values = {
    web-frontend = {}
    api-backend  = {}
    database     = {}
  }
}

# Use the tags on resources
resource "google_compute_instance" "web_server" {
  name         = "web-server"
  machine_type = "e2-medium"
  zone         = "us-central1-a"

  tags = [
    module.environment_tags.tag_values_ids["prod"],
    module.application_tags.tag_values_ids["web-frontend"]
  ]

  # ... other configuration
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| parent | Parent resource for the tag key (organization/project ID). Format: `organizations/{org_id}` or `projects/{project_id}` | `string` | n/a | yes |
| tag_key_name | Short name for the tag key (e.g., environment, cost-center, security-zone) | `string` | n/a | yes |
| purpose | Purpose of the tag key. Valid values: `GCE_FIREWALL` or `null`. Use `GCE_FIREWALL` for firewall policy integration | `string` | `null` | no |
| purpose_data | Purpose data for GCE_FIREWALL purpose. Map with 'network' key containing the VPC network resource name | `map(string)` | `{}` | no |
| tag_values | Map of tag values to create. Key is the tag value name | `map(object({}))` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| tag_key_id | The ID of the created tag key |
| tag_key_name | The full name of the created tag key |
| tag_key_short_name | The short name of the created tag key |
| tag_values | Map of created tag values with their IDs, names, and short names |
| tag_values_ids | Map of tag value short names to their IDs |
| tag_values_names | Map of tag value short names to their full resource names |

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.5.0 |
| google | >= 7.0.0, < 8.0.0 |
| google-beta | >= 7.0.0, < 8.0.0 |

## Notes

- Tag keys must have unique short names within their parent resource
- Tag values must have unique short names within their tag key
- When using `GCE_FIREWALL` purpose, you must provide the `purpose_data` with the network configuration
- Tags can be attached to various GCP resources for organization, billing, and firewall policies
- Deleting a tag key will also delete all associated tag values

## Changelog

See [CHANGELOG.md](./CHANGELOG.md) for version history and changes.