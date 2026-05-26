# Azure Databricks Lakehouse Platform — Phase 1 Foundation

This Terraform configuration provisions the foundational Azure infrastructure for a modern **lakehouse data platform** built on Azure Databricks and ADLS Gen2.

---

## Architecture

```
SFTP / REST APIs / ADF
         │
         ▼
┌─────────────────────┐
│   ADLS Gen2 (raw)   │  ◄── Landing zone. Immutable raw source data.
└─────────────────────┘
         │
         ▼
┌─────────────────────┐
│ Azure Databricks    │  ◄── Compute, orchestration, Delta Lake engine.
│  (Premium SKU)      │
└─────────────────────┘
         │
    ┌────┴────┐
    ▼         ▼
 Bronze     Silver ──► Gold ──► Genie / Power BI / Synapse
(Delta)    (Delta)   (Delta)
```

Phase 1 provisions everything **above** the Databricks line.
Bronze/Silver/Gold tables, Auto Loader, and Unity Catalog are Phase 2+.

---

## What is provisioned

| Resource | Name pattern | Purpose |
|---|---|---|
| Resource Group | `rg-<project>-<env>` | Logical boundary for all resources |
| ADLS Gen2 Storage Account | `st<project><env>` | Lakehouse persistent storage |
| ADLS Gen2 Filesystem | `raw` | Landing zone for unprocessed source data |
| Databricks Workspace | `dbw-<project>-<env>` | Premium Databricks compute environment |
| Databricks Managed RG | `rg-<project>-<env>-databricks-managed` | Auto-managed compute resources |

---

## Prerequisites

| Tool | Minimum version | Install |
|---|---|---|
| Terraform | >= 1.5.0 | https://developer.hashicorp.com/terraform/install |
| Azure CLI | >= 2.50.0 | https://learn.microsoft.com/en-us/cli/azure/install-azure-cli |
| An Azure subscription | — | Contributor or Owner role required |

---

## Authentication

This configuration uses **Azure CLI authentication only** — no secrets or PATs are needed.

```bash
# 1. Log in
az login

# 2. If you have multiple subscriptions, set the target explicitly
az account list --output table
az account set --subscription "<subscription-id-or-name>"

# 3. Confirm the correct subscription is active
az account show --output table
```

---

## Deployment

```bash
# 1. Clone the repository and navigate to the terraform directory
cd terraform/

# 2. Create your variable file from the example
cp terraform.tfvars.example terraform.tfvars

# 3. Edit terraform.tfvars — set project_name, environment, location
#    Storage account names must be globally unique across Azure.

# 4. Initialise providers and modules
terraform init

# 5. Review the execution plan — read this carefully before applying
terraform plan

# 6. Apply (type 'yes' when prompted)
terraform apply

# 7. Review outputs
terraform output
```

Expected apply time: **~8–12 minutes** (Databricks workspace provisioning dominates).

---

## File reference

| File | Purpose |
|---|---|
| `versions.tf` | Pins Terraform and provider version constraints |
| `providers.tf` | Configures azurerm and databricks provider behaviour |
| `variables.tf` | Declares all input variables with descriptions and validation |
| `locals.tf` | Centralised naming convention and tag merging logic |
| `main.tf` | Top-level orchestration; data sources; architectural notes |
| `rg.tf` | Azure Resource Group |
| `storage.tf` | ADLS Gen2 storage account and `raw` filesystem |
| `databricks.tf` | Databricks Workspace (Premium SKU) |
| `outputs.tf` | Exposes resource attributes for operators and downstream stacks |
| `terraform.tfvars.example` | Template for local variable values (copy → `terraform.tfvars`) |
| `.gitignore` | Prevents accidental commit of state, secrets, and cache |

---

## Remote state (recommended before team use)

Phase 1 uses local state by default. Before sharing with a team, migrate to Azure Blob Storage:

```bash
# Create a storage account for state (one-off, outside this config)
az group create --name rg-tfstate --location eastus
az storage account create --name sttfstate<suffix> --resource-group rg-tfstate \
  --sku Standard_LRS --kind StorageV2 --min-tls-version TLS1_2
az storage container create --name tfstate --account-name sttfstate<suffix>
```

Then add to `versions.tf`:

```hcl
terraform {
  backend "azurerm" {
    resource_group_name  = "rg-tfstate"
    storage_account_name = "sttfstate<suffix>"
    container_name       = "tfstate"
    key                  = "phase1/terraform.tfstate"
  }
}
```

Run `terraform init -migrate-state` to move existing state.

---

## Naming conventions

| Resource type | Pattern | Example |
|---|---|---|
| Resource Group | `rg-<project>-<env>` | `rg-lakehouse-prod` |
| Storage Account | `st<project><env>` | `stlakehouseprod` |
| Databricks Workspace | `dbw-<project>-<env>` | `dbw-lakehouse-prod` |
| Managed Resource Group | `rg-<project>-<env>-databricks-managed` | `rg-lakehouse-prod-databricks-managed` |

---

## Suggested Phase 2 enhancements

| Area | Enhancement |
|---|---|
| **Networking** | VNET injection for Databricks (no public IPs), NSG rules, private endpoints for ADLS |
| **Security** | Managed Identity for Databricks → ADLS (replace storage key access) |
| **Unity Catalog** | Metastore creation and workspace assignment, external locations, catalogs |
| **Medallion containers** | Provision `bronze`, `silver`, `gold` filesystems with distinct lifecycle policies |
| **Key Vault** | Store connection strings; integrate with Databricks secret scopes |
| **Monitoring** | Diagnostic settings → Log Analytics workspace; Databricks audit logs |
| **CI/CD** | Service Principal auth, GitHub Actions / Azure DevOps pipeline, `terraform plan` PR checks |
| **Cost management** | Azure Budget alerts; Databricks cluster auto-termination policies |
| **Auto Loader** | Delta Live Tables pipeline: raw → bronze ingestion |

---

## How this fits the lakehouse architecture

```
Phase 1 (this config)          Phase 2                    Phase 3
──────────────────────         ─────────────────          ──────────────
Resource Group           ──►   Unity Catalog        ──►   DLT Pipelines
ADLS Gen2 (raw)          ──►   Bronze/Silver/Gold   ──►   Genie / BI
Databricks Workspace     ──►   Managed Identity     ──►   Dashboards
                               Private Networking         dbt / semantic layer
```

Each phase builds on the foundation laid here without requiring destructive changes.
