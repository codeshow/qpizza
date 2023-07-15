#!/bin/bash
set -ex

bucket_name=""
bucket_exists=$(aws s3api head-bucket --bucket $bucket_name 2>/dev/null && echo "yes" || echo "no")


terraform apply --auto-approve
