$environment = $args[0]

$terraformRoot = Split-Path -Parent $PSScriptRoot
Set-Location $terraformRoot

$initMarker = Join-Path $terraformRoot ".terraform\terraform.tfstate"
if (-not (Test-Path $initMarker)) {
    terraform init -backend-config="key=$environment/stepwise-databricks.tfstate"
}

terraform validate
terraform apply -auto-approve -var="environment=$environment" -var="resource_group_name=rg-stepwise-databricks-$environment"
