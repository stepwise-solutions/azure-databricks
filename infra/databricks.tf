resource "azurerm_databricks_workspace" "dbw" {
  name                = "dbw-stepwise-dev"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location

  sku = "premium"

  tags = {
    environment = "dev"
    project     = "stepwise"
  }
}

resource "azurerm_databricks_access_connector" "connector" {
  name                = "dbx-access-connector"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location

  identity {
    type = "SystemAssigned"
  }
}

resource "azurerm_role_assignment" "contributor" {
  scope                = azurerm_storage_account.adls.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = azurerm_databricks_access_connector.connector.identity[0].principal_id
}

resource "databricks_storage_credential" "adls_credential" {
  name = "adls-storage-credential"

  azure_managed_identity {
    access_connector_id = azurerm_databricks_access_connector.connector.id
  }

  comment = "Storage credential for ADLS Gen2 via Access Connector"
}

resource "databricks_external_location" "unitycatalog" {
  name            = "unitycatalog-root"
  url             = "abfss://unitycatalog@ststepwisedl001.dfs.core.windows.net/"
  credential_name = databricks_storage_credential.adls_credential.name
}

resource "databricks_external_location" "raw" {
  name = "raw-external-location"
  url = "abfss://raw@${azurerm_storage_account.adls.name}.dfs.core.windows.net/"
  credential_name = databricks_storage_credential.adls_credential.name
  comment = "External location for RAW data layer in ADLS Gen2"
}

resource "databricks_catalog" "citymoves_catalog" {
  name    = "citymoves"
  comment = "CityMoves catalog"
}

resource "databricks_schema" "citymoves_raw" {
  catalog_name = databricks_catalog.citymoves_catalog.name
  name         = "raw"
}

resource "databricks_volume" "transit" {
  name             = "transit"
  catalog_name     = databricks_catalog.citymoves_catalog.name
  schema_name      = databricks_schema.citymoves_raw.name
  volume_type      = "EXTERNAL"
  storage_location = databricks_external_location.raw.url
}