output "id" {
  description = "The Unity Catalog storage credential ID."
  value       = databricks_storage_credential.this.id
}

output "name" {
  description = "The Unity Catalog storage credential name."
  value       = databricks_storage_credential.this.name
}

output "access_connector_id" {
  description = "The Azure resource ID of the Databricks Access Connector used by this storage credential."
  value       = databricks_storage_credential.this.azure_managed_identity[0].access_connector_id
}
