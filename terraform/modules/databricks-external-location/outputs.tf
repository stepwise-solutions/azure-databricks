output "id" {
  description = "The Unity Catalog external location ID."
  value       = databricks_external_location.this.id
}

output "name" {
  description = "The Unity Catalog external location name."
  value       = databricks_external_location.this.name
}

output "url" {
  description = "The ADLS Gen2 URL for the external location."
  value       = databricks_external_location.this.url
}

output "credential_name" {
  description = "The storage credential used by this external location."
  value       = databricks_external_location.this.credential_name
}
