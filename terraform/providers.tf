provider "azurerm" {
  features {}

  subscription_id = var.subscription_id
}

provider "databricks" {
  host                        = module.databricks_workspace.workspace_url
  azure_workspace_resource_id = module.databricks_workspace.id
}
