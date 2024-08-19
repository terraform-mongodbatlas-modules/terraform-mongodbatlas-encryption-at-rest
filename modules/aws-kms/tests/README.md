## Instructions on how to run the terraform module tests

1. The Terraform version should be the latest (i.e. v1.9.0): this is advised because on earlier versions, tests were at beta stage.

2. Through terminal, set up the following environment variables: 
    -  `export MONGODB_ATLAS_PUBLIC_KEY="<YOUR_PUBLIC_KEY>"`
    -  `export MONGODB_ATLAS_PRIVATE_KEY="<YOUR_PRIVATE_KEY>"`
    -  `export MONGODB_ATLAS_BASE_URL="https://cloud-dev.mongodb.com/"` 
    -  `export TF_VAR_org_id=<YOUR_ORG_ID>`
    -  `export AWS_ACCESS_KEY_ID="<YOUR_ACCESS_KEY>"`
    -  `export AWS_SECRET_ACCESS_KEY="<YOUR_SECRET_KEY>"`
    -  `export TF_VAR_aws_kms_key_arn="<YOUR_KMS_KEY_ARN>"`

3. Run from terminal the command `cd modules/aws-kms`

4. Run from terminal the command `terraform init`

5. Run from terminal the command `terraform test`
