module "resource_group" {
  source = "./modules/resource-group"

  name        = var.resource_group_name
  location    = var.location
  environment = var.environment
  tags        = var.tags
}

module "data_lake" {
  source = "./modules/data-lake"

  storage_account_name     = var.data_lake_storage_account_name
  resource_group_name      = module.resource_group.name
  location                 = module.resource_group.location
  account_replication_type = var.data_lake_account_replication_type
  filesystem_names         = var.data_lake_filesystem_names
  tags                     = var.tags
}

module "databricks_workspace" {
  source = "./modules/databricks-workspace"

  name                        = var.databricks_workspace_name
  resource_group_name         = module.resource_group.name
  location                    = module.resource_group.location
  sku                         = var.databricks_sku
  managed_resource_group_name = var.databricks_managed_resource_group_name
  tags                        = var.tags
}

module "databricks_access_connector" {
  source = "./modules/databricks-access-connector"

  name                = var.databricks_access_connector_name
  resource_group_name = module.resource_group.name
  location            = module.resource_group.location
  storage_account_id  = module.data_lake.storage_account_id
  tags                = var.tags

  depends_on = [module.data_lake]
}

module "databricks_storage_credential" {
  source = "./modules/databricks-storage-credential"

  name                = var.databricks_storage_credential_name
  access_connector_id = module.databricks_access_connector.id

  depends_on = [
    module.databricks_workspace,
    module.databricks_access_connector,
  ]
}

module "databricks_external_location" {
  for_each = toset(var.data_lake_filesystem_names)

  source = "./modules/databricks-external-location"

  name            = "${var.databricks_external_location_name_prefix}-${each.key}"
  url             = format("abfss://%s@%s.dfs.core.windows.net/", each.key, module.data_lake.storage_account_name)
  credential_name = module.databricks_storage_credential.name

  depends_on = [
    module.databricks_storage_credential,
    module.data_lake,
  ]
}

module "databricks_unity_catalog" {
  source = "./modules/databricks-unity-catalog"

  catalog_name = local.databricks_catalog_name
  schema_name  = var.databricks_schema_name
  storage_root = format(
    "abfss://%s@%s.dfs.core.windows.net/%s",
    var.databricks_catalog_storage_filesystem,
    module.data_lake.storage_account_name,
    local.databricks_catalog_name,
  )

  depends_on = [
    module.databricks_external_location,
    module.databricks_storage_credential,
  ]
}
