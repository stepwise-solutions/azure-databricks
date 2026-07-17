variable "name" {
  description = "The name of the Azure Resource Group."
  type        = string
}

variable "location" {
  description = "The Azure region where the Resource Group will be created."
  type        = string
}

variable "environment" {
  description = "The deployment environment name (for example, dev, test, uat, prod)."
  type        = string
}

variable "tags" {
  description = "A map of tags to apply to the Resource Group."
  type        = map(string)
  default     = {}
}
