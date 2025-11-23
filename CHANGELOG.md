# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [v1.0.0] - 2025-11-23

### Added
- Initial release of GCP Tags module
- Support for creating tag keys with configurable parent (organization or project)
- Support for creating multiple tag values under a tag key
- GCE_FIREWALL purpose support for firewall policy integration
- Purpose data configuration for GCE_FIREWALL tag keys
- Comprehensive outputs for tag key and tag values information
- Input validation for purpose field (null or GCE_FIREWALL only)
- Dynamic tag value creation using for_each loop

### Outputs
- `tag_key_id` - The ID of the created tag key
- `tag_key_name` - The full name of the created tag key
- `tag_key_short_name` - The short name of the created tag key
- `tag_values` - Complete map of tag values with IDs, names, and short names
- `tag_values_ids` - Map of tag value short names to their IDs
- `tag_values_names` - Map of tag value short names to their full resource names

### Requirements
- Terraform >= 1.5.0
- Google Provider >= 7.0.0, < 8.0.0
- Google Beta Provider >= 7.0.0, < 8.0.0