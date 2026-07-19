variable "catalog_name" {
  description = "The name of the Unity Catalog catalog."
  type        = string
}

variable "schemas" {
  description = "The list of schema names to create within the catalog."
  type        = list(string)
  default     = []
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
  description = "An optional comment describing schemas within the catalog."
  type        = string
  default     = "Schema managed by Terraform"
}
