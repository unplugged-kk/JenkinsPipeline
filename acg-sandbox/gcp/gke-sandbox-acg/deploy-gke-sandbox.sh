#!/bin/bash

echo -n "Enter Sandbox Project ID "
read project_id 
export TF_VAR_project_id=$project_id

terraform init

terraform plan

terraform apply --auto-approve
