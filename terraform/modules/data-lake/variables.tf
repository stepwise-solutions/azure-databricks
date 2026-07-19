variable "storage_account_name" {
  description = "The name of the Data Lake Storage Account. Must be globally unique, 3-24 characters, lowercase letters and numbers only."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the Resource Group where the Data Lake will be created."
  type        = string
}

variable "location" {
  description = "The Azure region where the Data Lake will be created."
  type        = string
}

variable "account_replication_type" {
  description = "The replication type for the Storage Account (for example, LRS, GRS, ZRS)."
  type        = string
  default     = "LRS"
}

variable "filesystem_names" {
  description = "A list of Data Lake Gen2 filesystem names to create."
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "A map of tags to apply to the Data Lake Storage Account."
  type        = map(string)
  default     = {}
}
