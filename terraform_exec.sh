#!/bin/bash
set -o nounset
set -o errexit
 
echo "###############################"
echo "## Starting Terraform script ##"
echo "###############################"


COMMAND=${TERRAFORM_COMMAND}
APPLY="apply"
DESTROY="destroy"

terraform init \
-backend-config="subscription_id=${ARM_SUBSCRIPTION_ID}" \
-backend-config="storage_account_name=dotnetkeyvaultmanagement" \
-backend-config="container_name=tfstatedev" \
-backend-config="key=vis.terraform.tfstate" \
-backend-config="resource_group_name=myAzureKeyVault" \
-backend-config="tenant_id=${ARM_TENANT_ID}"

terraform validate

terraform plan 
if [ $COMMAND == $DESTROY ]; then
    echo "###############################"
    echo "## Executing terraform destroy ##"
    echo "###############################"
    terraform destroy --auto-approve 
fi
 
if [ $COMMAND == $APPLY ]; then
    echo "###############################"
    echo "## Executing terraform apply ##"
    echo "###############################"
    terraform apply --auto-approve 
fi
