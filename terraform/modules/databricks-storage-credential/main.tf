resource "databricks_storage_credential" "this" {
  name = var.name

  azure_managed_identity {
    access_connector_id = var.access_connector_id
  }

  comment = var.comment
}
