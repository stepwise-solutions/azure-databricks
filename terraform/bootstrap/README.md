# Terraform Bootstrap

Terraform configuration that provisions the shared Azure resources required for remote state storage. Run this project **once** to create a centralised state backend used by all environments (Dev, Test, UAT, Prod).

## Purpose

This bootstrap project creates:

- One dedicated Resource Group for Terraform state
- One shared Storage Account for Terraform state files
- One private Blob Storage container for all environment state files

Bootstrap resources are **not environment-specific**. Environment separation is handled through the Terraform backend `key` in future projects — not through separate storage accounts or resource groups.

```text
Azure Storage Account
└── tfstate container
    ├── dev/
    │   └── resource-group.tfstate
    ├── test/
    │   └── resource-group.tfstate
    ├── uat/
    │   └── resource-group.tfstate
    └── prod/
        └── resource-group.tfstate
```

## Why bootstrap is separate

Bootstrap Terraform is kept apart from workload/platform Terraform because it creates the backend infrastructure that those projects depend on.

**Lifecycle:**

1. Run bootstrap Terraform locally (using local state).
2. Create the shared Terraform state storage resources.
3. Configure future Terraform projects to use the AzureRM backend.
4. Use backend state keys to separate environments.

This project must use Terraform's default local backend. Configuring an AzureRM backend here would create a circular dependency — this project creates the Storage Account that other projects use as their remote backend.

This project does not deploy Databricks, networking, or other workload resources.

## Prerequisites

- [Terraform](https://developer.hashicorp.com/terraform/install) >= 1.5.0
- [Azure CLI](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli) authenticated (`az login`)
- Permissions to create Resource Groups and Storage Accounts in your subscription

## Usage

Run all commands from the `terraform/bootstrap/` directory.

```bash
terraform init
terraform validate
terraform plan
terraform apply
```

Review the plan carefully before confirming. This is typically a one-time deployment.

## Configuration

Update `terraform.tfvars` before applying:

| Variable | Description |
|----------|-------------|
| `subscription_id` | Target Azure subscription |
| `storage_account_name` | Globally unique name (3–24 chars, lowercase letters and numbers) |
| `location` | Azure region for state resources |
| `resource_group_name` | Resource Group name (default: `rg-terraform-state`) |
| `container_name` | Blob container name (default: `tfstate`) |

## Outputs

After a successful apply, retrieve the backend configuration values:

```bash
terraform output
```

| Output | Description |
|--------|-------------|
| `resource_group_name` | Shared state Resource Group name |
| `resource_group_id` | Shared state Resource Group ID |
| `storage_account_name` | Shared Storage Account name |
| `storage_account_id` | Shared Storage Account ID |
| `blob_container_name` | Private Blob container name |

## Configuring future Terraform backends

Future Terraform projects should configure an AzureRM backend pointing to this shared storage account. The Terraform code remains identical across environments — only the backend `key` changes.

### Development

```hcl
terraform {
  backend "azurerm" {
    resource_group_name  = "rg-terraform-state"
    storage_account_name = "stterraformstate"
    container_name       = "tfstate"
    key                  = "dev/resource-group.tfstate"
  }
}
```

### Production

```hcl
terraform {
  backend "azurerm" {
    resource_group_name  = "rg-terraform-state"
    storage_account_name = "stterraformstate"
    container_name       = "tfstate"
    key                  = "prod/resource-group.tfstate"
  }
}
```

Replace the `key` value with a unique path per environment and workload. Use the output values from this bootstrap deployment for `resource_group_name`, `storage_account_name`, and `container_name`.
