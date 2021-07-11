#!/bin/bash

echo -n "Enter Sandbox Project ID "
read PROJECT_ID

export SA=tf-acg-gcp-sandbox

gcloud iam service-accounts create $SA --display-name="$SA"

gcloud projects add-iam-policy-binding $PROJECT_ID \
    --member="serviceAccount:$SA@$PROJECT_ID.iam.gserviceaccount.com" \
    --role="roles/owner"

gcloud iam service-accounts keys create acgsandbox.json \
        --iam-account=$SA@$PROJECT_ID.iam.gserviceaccount.com

cloudshell download /home/$USER/acgsandbox.json 

