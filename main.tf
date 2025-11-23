/**
 * GCP Tag Keys and Tag Values Module
 * This module creates a tag key and associated tag values for resource organization
 */

# Create Tag Key
resource "google_tags_tag_key" "tag_key" {
  parent        = var.parent
  short_name    = var.tag_key_name

  purpose       = var.purpose
  purpose_data  = var.purpose == "GCE_FIREWALL" && length(var.purpose_data) > 0 ? var.purpose_data : null
}

# Create Tag Values
resource "google_tags_tag_value" "tag_values" {
  for_each = var.tag_values

  parent      = google_tags_tag_key.tag_key.id
  short_name  = each.key
}
