terraform init -backend-config="key=dev/resource-group.tfstate"
terraform validate
terraform plan -var="environment=dev" -var="resource_group_name=rg-stepwise-databricks-dev"
terraform apply -auto-approve -var="environment=dev" -var="resource_group_name=rg-stepwise-databricks-dev"
