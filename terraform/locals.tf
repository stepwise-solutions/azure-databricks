locals {
  catalog_names = {
    for project in var.catalog_project_names : project => "${var.environment}_${project}"
  }

  catalogs = {
    for project in var.catalog_project_names : project => {
      schemas = var.catalog_project_schemas[project]
    }
  }
}
