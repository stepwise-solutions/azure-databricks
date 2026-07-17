# Azure Databricks Terraform

Terraform configuration for deploying Azure infrastructure. The initial deployment creates a Resource Group for the development environment. The same Terraform code supports all environments — separation is achieved through variables and backend state keys, not duplicated configuration.

## Relationship to bootstrap

The [bootstrap project](bootstrap/) creates the shared remote state foundation:

- Terraform state Resource Group (`rg-terraform-state`)
- Shared Storage Account (`ststepwisetfstate`)
- Private blob container (`tfstate`)

This workload project **consumes** those bootstrap resources. It does not create state storage resources and does not use local state.

**Lifecycle:**

1. Run `terraform/bootstrap` once to create the shared state backend.
2. Configure `backend.tf` in this project to point at the bootstrap storage account.
3. Deploy workload resources — state is stored remotely under an environment-specific key.

## Folder structure

```text
terraform/
├── modules/
│   └── resource-group/    # Reusable Resource Group module
├── main.tf                # Root module — calls child modules
├── variables.tf           # Input variable definitions
├── outputs.tf             # Output values
├── providers.tf           # AzureRM provider configuration
├── versions.tf            # Terraform and provider version constraints
├── backend.tf             # AzureRM remote backend (bootstrap storage)
├── terraform.tfvars       # Development environment values
├── bootstrap/             # Shared state backend (run once)
├── docs/                  # Additional documentation
└── scripts/               # Helper scripts
```

## Remote backend configuration

State is stored in the shared bootstrap Storage Account. The `backend.tf` file configures the AzureRM backend:

```hcl
terraform {
  backend "azurerm" {
    resource_group_name  = "rg-terraform-state"
    storage_account_name = "ststepwisetfstate"
    container_name       = "tfstate"
    key                  = "dev/resource-group.tfstate"
  }
}
```

Update the backend values to match your bootstrap deployment outputs if they differ.

## State key environment separation

All environments share one Storage Account and container. Environment isolation is provided by the backend `key`:

```text
tfstate/
├── dev/resource-group.tfstate
├── test/resource-group.tfstate
├── uat/resource-group.tfstate
└── prod/resource-group.tfstate
```

The Terraform code remains identical across environments. Only the backend key and input variables change.

## Prerequisites

- Bootstrap project deployed (`terraform/bootstrap`)
- [Terraform](https://developer.hashicorp.com/terraform/install) >= 1.5.0
- [Azure CLI](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli) authenticated (`az login`)
- Permissions to create Resource Groups in your subscription

## Deployment

Run all commands from the `terraform/` directory.

```bash
terraform init
terraform validate
terraform plan
terraform apply
```

Update `subscription_id` in `terraform.tfvars` with your Azure subscription ID before applying.

## Deploying another environment

To deploy a different environment, reinitialise with a new backend key and supply environment-specific variables. No code changes are required.

### Example: production

```bash
terraform init \
  -backend-config="key=prod/resource-group.tfstate"

terraform plan \
  -var="environment=prod" \
  -var="resource_group_name=rg-azure-databricks-prod" \
  -var='tags={"Environment"="prod","ManagedBy"="Terraform","Project"="Azure Databricks"}'

terraform apply
```

Alternatively, use a separate `prod.tfvars` file and pass it with `-var-file`.
