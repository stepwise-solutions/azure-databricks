resource "azurerm_resource_group" "this" {
  name     = var.name
  location = var.location
  tags     = var.tags
}

check "environment_tag_consistency" {
  assert {
    condition     = lookup(var.tags, "Environment", "") == var.environment
    error_message = "The environment variable must match the Environment tag value."
  }
}
