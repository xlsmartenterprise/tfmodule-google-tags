output "tag_key_id" {
  description = "The ID of the created tag key"
  value       = google_tags_tag_key.tag_key.id
}

output "tag_key_name" {
  description = "The name of the created tag key"
  value       = google_tags_tag_key.tag_key.name
}

output "tag_key_short_name" {
  description = "The short name of the created tag key"
  value       = google_tags_tag_key.tag_key.short_name
}

output "tag_values" {
  description = "Map of created tag values with their IDs and names"
  value = {
    for k, v in google_tags_tag_value.tag_values : k => {
      id         = v.id
      name       = v.name
      short_name = v.short_name
    }
  }
}

output "tag_values_ids" {
  description = "Map of tag value short names to their IDs"
  value = {
    for k, v in google_tags_tag_value.tag_values : k => v.id
  }
}

output "tag_values_names" {
  description = "Map of tag value short names to their full resource names"
  value = {
    for k, v in google_tags_tag_value.tag_values : k => v.name
  }
}
