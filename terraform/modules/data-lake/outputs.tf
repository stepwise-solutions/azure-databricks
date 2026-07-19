output "storage_account_id" {
  description = "The ID of the Data Lake Storage Account."
  value       = azurerm_storage_account.this.id
}

output "storage_account_name" {
  description = "The name of the Data Lake Storage Account."
  value       = azurerm_storage_account.this.name
}

output "primary_dfs_endpoint" {
  description = "The primary DFS endpoint for the Data Lake Storage Account."
  value       = azurerm_storage_account.this.primary_dfs_endpoint
}

output "primary_blob_endpoint" {
  description = "The primary Blob endpoint for the Data Lake Storage Account."
  value       = azurerm_storage_account.this.primary_blob_endpoint
}

output "filesystem_names" {
  description = "The names of the created Data Lake Gen2 filesystems."
  value       = [for filesystem in azurerm_storage_data_lake_gen2_filesystem.this : filesystem.name]
}
