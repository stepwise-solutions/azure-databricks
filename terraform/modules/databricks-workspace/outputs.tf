output "id" {
  description = "The ID of the Databricks workspace."
  value       = azurerm_databricks_workspace.this.id
}

output "workspace_id" {
  description = "The workspace ID of the Databricks workspace."
  value       = azurerm_databricks_workspace.this.workspace_id
}

output "name" {
  description = "The name of the Databricks workspace."
  value       = azurerm_databricks_workspace.this.name
}

output "workspace_url" {
  description = "The URL of the Databricks workspace."
  value       = azurerm_databricks_workspace.this.workspace_url
}

output "managed_resource_group_id" {
  description = "The ID of the managed Resource Group created for Databricks compute resources."
  value       = azurerm_databricks_workspace.this.managed_resource_group_id
}

output "managed_resource_group_name" {
  description = "The name of the managed Resource Group created for Databricks compute resources."
  value       = azurerm_databricks_workspace.this.managed_resource_group_name
}
