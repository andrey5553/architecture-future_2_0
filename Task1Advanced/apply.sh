#!/bin/bash

source aws_secrets.sh

function terraform_apply {
  path_to=$1
  path_init=$PWD
  
  echo -e "Apply terraform config in '$path_to'..."
  cd $path_to

  terraform init
  terraform plan
  terraform apply
  retVal=$?

  cd $path_init
  if [ $retVal -ne 0 ]; then
    exit $retVal
  fi
}

terraform_apply "envs/dev"
terraform_apply "envs/prod"
terraform_apply "envs/stage"
