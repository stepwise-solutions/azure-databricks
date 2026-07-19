variable "name" {
  description = "The name of the Databricks Access Connector."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the Resource Group where the Access Connector will be created."
  type        = string
}

variable "location" {
  description = "The Azure region where the Access Connector will be created."
  type        = string
}

variable "storage_account_id" {
  description = "The resource ID of the ADLS Gen2 storage account to grant Storage Blob Data Contributor access. Set to null to skip role assignment."
  type        = string
  default     = null
}

variable "tags" {
  description = "A map of tags to apply to the Access Connector."
  type        = map(string)
  default     = {}
}
