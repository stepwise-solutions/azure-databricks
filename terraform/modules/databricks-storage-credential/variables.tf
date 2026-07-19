variable "name" {
  description = "The name of the Unity Catalog storage credential."
  type        = string
}

variable "access_connector_id" {
  description = "The Azure resource ID of the Databricks Access Connector (for example, dac-stepwise-dev)."
  type        = string
}

variable "comment" {
  description = "An optional comment describing the storage credential."
  type        = string
  default     = "Managed identity storage credential managed by Terraform"
}
