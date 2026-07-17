output "resource_group_name" {
  description = "The name of the shared Terraform state Resource Group."
  value       = azurerm_resource_group.terraform_state.name
}

output "resource_group_id" {
  description = "The ID of the shared Terraform state Resource Group."
  value       = azurerm_resource_group.terraform_state.id
}

output "storage_account_name" {
  description = "The name of the shared Terraform state Storage Account."
  value       = azurerm_storage_account.terraform_state.name
}

output "storage_account_id" {
  description = "The ID of the shared Terraform state Storage Account."
  value       = azurerm_storage_account.terraform_state.id
}

output "blob_container_name" {
  description = "The name of the private Blob Storage container for Terraform state."
  value       = azurerm_storage_container.terraform_state.name
}
