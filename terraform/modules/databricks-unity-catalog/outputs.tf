output "catalog_name" {
  description = "The Unity Catalog catalog name."
  value       = databricks_catalog.this.name
}

output "catalog_id" {
  description = "The Unity Catalog catalog ID."
  value       = databricks_catalog.this.id
}

output "schema_name" {
  description = "The Unity Catalog schema name."
  value       = databricks_schema.this.name
}

output "schema_id" {
  description = "The Unity Catalog schema ID."
  value       = databricks_schema.this.id
}

output "storage_root" {
  description = "The storage root path for the catalog."
  value       = databricks_catalog.this.storage_root
}
