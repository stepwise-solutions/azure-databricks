output "resource_group_name" {
  value = azurerm_resource_group.rg.name
}

output "resource_group_location" {
  value = azurerm_resource_group.rg.location
}

output "storage_account_name" {
  value = azurerm_storage_account.adls.name
}

output "raw_container" {
  value = azurerm_storage_data_lake_gen2_filesystem.raw.name
}

output "bronze_container" {
  value = azurerm_storage_data_lake_gen2_filesystem.bronze.name
}

output "silver_container" {
  value = azurerm_storage_data_lake_gen2_filesystem.silver.name
}

output "gold_container" {
  value = azurerm_storage_data_lake_gen2_filesystem.gold.name
}

output "databricks_workspace_url" {
  value = azurerm_databricks_workspace.dbw.workspace_url
}

output "databricks_workspace_id" {
  value = azurerm_databricks_workspace.dbw.id
}

output "databricks_workspace_managed_rg" {
  value = azurerm_databricks_workspace.dbw.managed_resource_group_name
}