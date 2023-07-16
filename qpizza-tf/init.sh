#!/bin/bash

AWS_ACCOUNT_ID=$(aws sts get-caller-identity --query Account --output=text)
TFSTATE_REGION=$(aws configure get region)
TFSTATE_KEY="tfstate"
TFSTATE_BUCKET="tfstate--${AWS_ACCOUNT_ID}--${TFSTATE_REGION}"

echo "Initializing terraform from $TFSTATE_BUCKET"
terraform init  -migrate-state \
    -backend-config="bucket=${TFSTATE_BUCKET}" \
    -backend-config="key=${TFSTATE_KEY}" \
    -backend-config="region=${TFSTATE_REGION}" 

