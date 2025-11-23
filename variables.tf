variable "parent" {
  description = "Parent resource for the tag key (organization/project ID). Format: organizations/{org_id} or projects/{project_id}"
  type        = string
}

variable "tag_key_name" {
  description = "Short name for the tag key (e.g., bns-security-prod-tags)"
  type        = string
}

variable "purpose" {
  description = "Purpose of the tag key. Valid values: GCE_FIREWALL or null"
  type        = string
  default     = null

  validation {
    condition     = var.purpose == null || var.purpose == "GCE_FIREWALL"
    error_message = "Purpose must be either null or 'GCE_FIREWALL'."
  }
}

variable "purpose_data" {
  description = "Purpose data for GCE_FIREWALL purpose. Map with 'network' key containing the VPC network resource name"
  type        = map(string)
  default     = {}
}

variable "tag_values" {
  description = "Map of tag values to create. Key is the tag value name, value is an object with description"
  type = map(object({
  }))
  default = {}
}