#!/bin/sh

#Deploy AWX on Docker-Desktop

#Prerequesite ( configure docker-desktop & k8s with minimum 3 cpu and 4 gb RAM)

# Enable Ingress

kubectl apply -f docker-desktop-ingress.yaml

#Deploy AWX with Operator

kubectl  apply -f docker-desktop-awx-operator.yaml

kubectl apply -f docker-desktop-custom-config.yml

#check awx-operator pod is ready or not if the deployment is not up in 10-15 min.

# while [[ $(kubectl get pods -l name=awx-operator -o 'jsonpath={..status.conditions[?(@.type=="Ready")].status}') != "True" ]]; do echo "waiting for pod" && sleep 1; done


#Check all pods are Ready or not

# while [[ $(kubectl get pods -l app.kubernetes.io/name=awx -o 'jsonpath={..status.conditions[?(@.type=="Ready")].status}') != "True" ]]; do echo "waiting for pod" && sleep 1; done


# awx Postgres pod is ready or not

# while [[ $(kubectl get pods -l app.kubernetes.io/name=awx-postgres -o 'jsonpath={..status.conditions[?(@.type=="Ready")].status}') != "True" ]]; do echo "waiting for pod" && sleep 1; done


# Get AWX Admin pass

kubectl  get secret awx-admin-password -o jsonpath='{.data.password}' | base64 --decode
