resource "azurerm_resource_group" "rg" {
  name     = "rg-stepwise-dev"
  location = "West Europe"

  tags = {
    environment = "dev"
    project     = "stepwise"
  }
}

resource "azurerm_storage_account" "adls" {
  name                     = "ststepwisedl001" # must be globally unique
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location

  account_tier             = "Standard"
  account_replication_type = "LRS"

  # Enables ADLS Gen2 (hierarchical namespace)
  is_hns_enabled = true

  min_tls_version = "TLS1_2"

  allow_nested_items_to_be_public = false

  tags = {
    environment = "dev"
    project     = "stepwise"
  }
}

# -------------------------
# Data Lake Containers
# -------------------------

resource "azurerm_storage_data_lake_gen2_filesystem" "raw" {
  name               = "raw"
  storage_account_id = azurerm_storage_account.adls.id
}

resource "azurerm_storage_data_lake_gen2_filesystem" "bronze" {
  name               = "bronze"
  storage_account_id = azurerm_storage_account.adls.id
}

resource "azurerm_storage_data_lake_gen2_filesystem" "silver" {
  name               = "silver"
  storage_account_id = azurerm_storage_account.adls.id
}

resource "azurerm_storage_data_lake_gen2_filesystem" "gold" {
  name               = "gold"
  storage_account_id = azurerm_storage_account.adls.id
}

resource "azurerm_storage_data_lake_gen2_filesystem" "unitycatalog" {
  name               = "unitycatalog"
  storage_account_id = azurerm_storage_account.adls.id
}