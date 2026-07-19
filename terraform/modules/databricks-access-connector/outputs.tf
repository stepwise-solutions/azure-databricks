output "id" {
  description = "The ID of the Databricks Access Connector."
  value       = azurerm_databricks_access_connector.this.id
}

output "name" {
  description = "The name of the Databricks Access Connector."
  value       = azurerm_databricks_access_connector.this.name
}

output "identity_principal_id" {
  description = "The principal ID of the managed identity configured on the Access Connector."
  value       = azurerm_databricks_access_connector.this.identity[0].principal_id
}

output "identity_tenant_id" {
  description = "The tenant ID of the managed identity configured on the Access Connector."
  value       = azurerm_databricks_access_connector.this.identity[0].tenant_id
}

output "identity_type" {
  description = "The managed identity type configured on the Access Connector."
  value       = azurerm_databricks_access_connector.this.identity[0].type
}
