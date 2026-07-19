resource "azurerm_databricks_access_connector" "this" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location

  identity {
    type = "SystemAssigned"
  }

  tags = var.tags
}

resource "azurerm_role_assignment" "storage_blob_data_contributor" {
  count = var.storage_account_id != null ? 1 : 0

  scope                = var.storage_account_id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = azurerm_databricks_access_connector.this.identity[0].principal_id

  depends_on = [azurerm_databricks_access_connector.this]
}
