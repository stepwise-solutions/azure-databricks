resource "databricks_catalog" "this" {
  name         = var.catalog_name
  storage_root = var.storage_root
  comment      = var.catalog_comment
}

resource "databricks_schema" "this" {
  for_each = toset(var.schemas)

  catalog_name = databricks_catalog.this.name
  name         = each.value
  comment      = var.schema_comment

  depends_on = [databricks_catalog.this]
}
