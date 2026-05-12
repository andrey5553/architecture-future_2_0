#!/bin/bash

source aws_secrets.sh

function terraform_destroy {
  path_to=$1
  path_init=${PWD}
  
  echo -e "Destroy terraform VMs config in '$path_to'..."
  cd $path_to

  terraform destroy
  retVal=$?

  cd $path_init
  if [ $retVal -ne 0 ]; then
    exit $retVal
  fi
}

terraform_destroy "envs/dev"
terraform_destroy "envs/prod"
terraform_destroy "envs/stage"
