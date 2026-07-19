output "catalog_name" {
  description = "The Unity Catalog catalog name."
  value       = databricks_catalog.this.name
}

output "catalog_id" {
  description = "The Unity Catalog catalog ID."
  value       = databricks_catalog.this.id
}

output "storage_root" {
  description = "The storage root path for the catalog."
  value       = databricks_catalog.this.storage_root
}

output "schema_names" {
  description = "The schema names created within the catalog."
  value       = [for schema in databricks_schema.this : schema.name]
}

output "schema_ids" {
  description = "The fully qualified schema IDs keyed by schema name."
  value       = { for name, schema in databricks_schema.this : name => schema.id }
}
