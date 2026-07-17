terraform {
  backend "azurerm" {
    # Values from the bootstrap project (terraform/bootstrap).
    resource_group_name  = "rg-terraform-state"
    storage_account_name = "ststepwisetfstate"
    container_name       = "tfstate"

    # The key separates environments within the shared tfstate container.
    # Dev state:  dev/resource-group.tfstate
    # Prod state: prod/resource-group.tfstate
    #
    # CI/CD can override this at init time without changing Terraform code:
    #   terraform init -backend-config="key=prod/resource-group.tfstate"
    key = "dev/resource-group.tfstate"
  }
}
