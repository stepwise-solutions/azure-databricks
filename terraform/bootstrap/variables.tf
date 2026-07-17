variable "subscription_id" {
  description = "The Azure subscription ID to deploy resources into."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the Resource Group that will hold shared Terraform state resources."
  type        = string
  default     = "rg-terraform-state"
}

variable "storage_account_name" {
  description = "The name of the shared Storage Account for Terraform state. Must be globally unique, 3-24 characters, lowercase letters and numbers only."
  type        = string
}

variable "container_name" {
  description = "The name of the private Blob Storage container that will store state files for all environments."
  type        = string
  default     = "tfstate"
}

variable "location" {
  description = "The Azure region where shared Terraform state resources will be deployed."
  type        = string
}

variable "tags" {
  description = "A map of tags to apply to all shared Terraform state resources."
  type        = map(string)
  default = {
    ManagedBy = "Terraform"
    Project   = "Terraform State"
    Purpose   = "Remote Backend"
  }
}
