variable "name" {
  description = "The name of the Databricks workspace."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the Resource Group where the Databricks workspace will be created."
  type        = string
}

variable "location" {
  description = "The Azure region where the Databricks workspace will be created."
  type        = string
}

variable "sku" {
  description = "The SKU of the Databricks workspace (standard or premium)."
  type        = string
  default     = "premium"

  validation {
    condition     = contains(["standard", "premium"], var.sku)
    error_message = "The sku must be either standard or premium."
  }
}

variable "managed_resource_group_name" {
  description = "The name of the managed Resource Group where Azure places Databricks compute resources."
  type        = string
  default     = null
}

variable "tags" {
  description = "A map of tags to apply to the Databricks workspace."
  type        = map(string)
  default     = {}
}
