output "resource_group_name" {
  description = "The name of the deployed Resource Group."
  value       = module.resource_group.name
}

output "resource_group_id" {
  description = "The ID of the deployed Resource Group."
  value       = module.resource_group.id
}

output "resource_group_location" {
  description = "The Azure region of the deployed Resource Group."
  value       = module.resource_group.location
}
