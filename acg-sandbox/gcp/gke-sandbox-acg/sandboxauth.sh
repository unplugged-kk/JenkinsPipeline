#!/bin/bash

echo -n "Enter Sandbox Project ID "
read PROJECT_ID

export SA=tf-acg-gcp-sandbox

echo " User id is $USER"
echo " Project id is $PROJECT_ID"
echo " Service Account id is $SA"

echo " Enabling necessary APIS "

gcloud services enable container.googleapis.com storage.googleapis.com anthos.googleapis.com anthosgke.googleapis.com cloud.googleapis.com cloudresourcemanager.googleapis.com containerregistry.googleapis.com file.googleapis.com ; gcloud services list --enabled

echo " Creating Service Account "

gcloud iam service-accounts create $SA --display-name="$SA"

gcloud projects add-iam-policy-binding $PROJECT_ID \
    --member="serviceAccount:$SA@$PROJECT_ID.iam.gserviceaccount.com" \
    --role="roles/owner"

gcloud iam service-accounts keys create acgsandbox.json \
        --iam-account=$SA@$PROJECT_ID.iam.gserviceaccount.com

cloudshell download /home/$USER/acgsandbox.json 

