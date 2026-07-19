variable "name" {
  description = "The name of the Unity Catalog external location."
  type        = string
}

variable "url" {
  description = "The ADLS Gen2 path URL in abfss:// format."
  type        = string
}

variable "credential_name" {
  description = "The name of the Unity Catalog storage credential used to access this location."
  type        = string
}

variable "comment" {
  description = "An optional comment describing the external location."
  type        = string
  default     = "External location managed by Terraform"
}
