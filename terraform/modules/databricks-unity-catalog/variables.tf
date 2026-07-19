variable "catalog_name" {
  description = "The name of the Unity Catalog catalog."
  type        = string
}

variable "schema_name" {
  description = "The name of the Unity Catalog schema."
  type        = string
}

variable "storage_root" {
  description = "The ADLS Gen2 storage root for the catalog in abfss:// format."
  type        = string
}

variable "catalog_comment" {
  description = "An optional comment describing the catalog."
  type        = string
  default     = "Catalog managed by Terraform"
}

variable "schema_comment" {
  description = "An optional comment describing the schema."
  type        = string
  default     = "Schema managed by Terraform"
}
