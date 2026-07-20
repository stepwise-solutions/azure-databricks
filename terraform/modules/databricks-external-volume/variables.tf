variable "name" {
  description = "The name of the Unity Catalog external volume."
  type        = string
}

variable "catalog_name" {
  description = "The Unity Catalog catalog that will contain the volume."
  type        = string
}

variable "schema_name" {
  description = "The Unity Catalog schema that will contain the volume."
  type        = string
}

variable "storage_location" {
  description = "The ADLS Gen2 URL for the volume. Must be within an existing external location."
  type        = string
}

variable "comment" {
  description = "An optional comment describing the external volume."
  type        = string
  default     = "External volume managed by Terraform"
}
