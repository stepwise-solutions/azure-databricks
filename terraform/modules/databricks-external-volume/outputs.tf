output "id" {
  description = "The Unity Catalog external volume ID."
  value       = databricks_volume.this.id
}

output "name" {
  description = "The Unity Catalog external volume name."
  value       = databricks_volume.this.name
}

output "qualified_name" {
  description = "The fully qualified volume name (catalog.schema.volume)."
  value       = "${var.catalog_name}.${var.schema_name}.${var.name}"
}

output "storage_location" {
  description = "The ADLS Gen2 storage location for the external volume."
  value       = databricks_volume.this.storage_location
}
