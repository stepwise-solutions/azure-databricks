variable "subscription_id" {
  description = "The Azure subscription ID to deploy resources into."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the Azure Resource Group to create."
  type        = string
}

variable "location" {
  description = "The Azure region where resources will be deployed."
  type        = string
}

variable "environment" {
  description = "The deployment environment name (for example, dev, test, uat, prod)."
  type        = string
}

variable "tags" {
  description = "A map of tags to apply to deployed resources."
  type        = map(string)
  default     = {}
}

variable "data_lake_storage_account_name" {
  description = "The name of the Data Lake Storage Account. Must be globally unique, 3-24 characters, lowercase letters and numbers only."
  type        = string
}

variable "data_lake_account_replication_type" {
  description = "The replication type for the Data Lake Storage Account (for example, LRS, GRS, ZRS)."
  type        = string
  default     = "LRS"
}

variable "data_lake_filesystem_names" {
  description = "A list of Data Lake Gen2 filesystem names to create."
  type        = list(string)
  default     = []
}

variable "databricks_workspace_name" {
  description = "The name of the Databricks workspace."
  type        = string
}

variable "databricks_sku" {
  description = "The SKU of the Databricks workspace (standard or premium)."
  type        = string
  default     = "premium"

  validation {
    condition     = contains(["standard", "premium"], var.databricks_sku)
    error_message = "The databricks_sku must be either standard or premium."
  }
}

variable "databricks_managed_resource_group_name" {
  description = "The name of the managed Resource Group where Azure places Databricks compute resources."
  type        = string
  default     = null
}

variable "databricks_access_connector_name" {
  description = "The name of the Databricks Access Connector used for Unity Catalog managed identity authentication."
  type        = string
}

variable "databricks_storage_credential_name" {
  description = "The name of the Unity Catalog storage credential backed by the Databricks Access Connector managed identity."
  type        = string
}
