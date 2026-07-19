output "resource_group_name" {
  description = "The name of the deployed Resource Group."
  value       = module.resource_group.name
}

output "resource_group_id" {
  description = "The ID of the deployed Resource Group."
  value       = module.resource_group.id
}

output "resource_group_location" {
  description = "The Azure region of the deployed Resource Group."
  value       = module.resource_group.location
}

output "data_lake_storage_account_id" {
  description = "The ID of the Data Lake Storage Account."
  value       = module.data_lake.storage_account_id
}

output "data_lake_storage_account_name" {
  description = "The name of the Data Lake Storage Account."
  value       = module.data_lake.storage_account_name
}

output "data_lake_primary_dfs_endpoint" {
  description = "The primary DFS endpoint for the Data Lake Storage Account."
  value       = module.data_lake.primary_dfs_endpoint
}

output "data_lake_filesystem_names" {
  description = "The names of the created Data Lake Gen2 filesystems."
  value       = module.data_lake.filesystem_names
}

output "databricks_workspace_id" {
  description = "The ID of the Databricks workspace."
  value       = module.databricks_workspace.id
}

output "databricks_workspace_url" {
  description = "The URL of the Databricks workspace."
  value       = module.databricks_workspace.workspace_url
}

output "databricks_workspace_name" {
  description = "The name of the Databricks workspace."
  value       = module.databricks_workspace.name
}

output "databricks_managed_resource_group_name" {
  description = "The name of the managed Resource Group for Databricks compute resources."
  value       = module.databricks_workspace.managed_resource_group_name
}

output "databricks_access_connector_id" {
  description = "The ID of the Databricks Access Connector for Unity Catalog."
  value       = module.databricks_access_connector.id
}

output "databricks_access_connector_name" {
  description = "The name of the Databricks Access Connector for Unity Catalog."
  value       = module.databricks_access_connector.name
}

output "databricks_access_connector_identity_principal_id" {
  description = "The principal ID of the Access Connector managed identity for Unity Catalog storage credentials."
  value       = module.databricks_access_connector.identity_principal_id
}

output "databricks_storage_credential_id" {
  description = "The Unity Catalog storage credential ID."
  value       = module.databricks_storage_credential.id
}

output "databricks_storage_credential_name" {
  description = "The Unity Catalog storage credential name."
  value       = module.databricks_storage_credential.name
}

output "databricks_storage_credential_access_connector_id" {
  description = "The Access Connector ID referenced by the Unity Catalog storage credential."
  value       = module.databricks_storage_credential.access_connector_id
}

output "databricks_external_location_names" {
  description = "The names of the Unity Catalog external locations for the data lake."
  value       = { for filesystem, location in module.databricks_external_location : filesystem => location.name }
}

output "databricks_external_location_urls" {
  description = "The ADLS Gen2 URLs for the Unity Catalog external locations."
  value       = { for filesystem, location in module.databricks_external_location : filesystem => location.url }
}

output "databricks_catalog_name" {
  description = "The Unity Catalog catalog name."
  value       = module.databricks_unity_catalog.catalog_name
}

output "databricks_schema_name" {
  description = "The Unity Catalog schema name."
  value       = module.databricks_unity_catalog.schema_name
}

output "databricks_schema_id" {
  description = "The fully qualified Unity Catalog schema ID."
  value       = module.databricks_unity_catalog.schema_id
}

output "databricks_catalog_storage_root" {
  description = "The storage root path for the Unity Catalog catalog."
  value       = module.databricks_unity_catalog.storage_root
}
