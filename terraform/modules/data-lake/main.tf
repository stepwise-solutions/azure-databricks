resource "azurerm_storage_account" "this" {
  name                     = var.storage_account_name
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_kind             = "StorageV2"
  account_replication_type = var.account_replication_type

  is_hns_enabled = true

  min_tls_version                 = "TLS1_2"
  https_traffic_only_enabled      = true
  allow_nested_items_to_be_public = false

  tags = var.tags
}

resource "azurerm_storage_data_lake_gen2_filesystem" "this" {
  for_each = toset(var.filesystem_names)

  name               = each.value
  storage_account_id = azurerm_storage_account.this.id
}
