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
