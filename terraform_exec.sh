#!/bin/bash
set -o nounset
set -o errexit
 
echo "###############################"
echo "## Starting Terraform script ##"
echo "###############################"


COMMAND=${TERRAFORM_COMMAND}
APPLY="apply"
DESTROY="destroy"

terraform init 

terraform validate

terraform plan -input=false
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
