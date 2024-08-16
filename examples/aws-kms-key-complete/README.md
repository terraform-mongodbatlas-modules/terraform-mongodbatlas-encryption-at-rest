# encryption-at-rest-aws-kms-key - complete example

_Note: you can see the full source code in the [github repository](https://github.com/terraform-mongodbatlas-modules/terraform-mongodbatlas-encryption-at-rest/tree/main/examples/aws-kms-key-complete)_

This example sets up encryption at rest using an AWS KMS for your Atlas Project. Specifically, it does the following: 
- Creates encryption key in AWS KMS.
- Using the aws-kms submodule:
    - Creates an IAM role and policy so that Atlas can access the key.
    - Enables encryption at rest for the Atlas Project.
- Creates a Cluster with encryption at rest enabled.

## Usage

- Set the following variable: 

    - `project_id`: Unique 24-hexadecimal character string that identifies the Atlas project

- Set the following environment variables:

    -  `export MONGODB_ATLAS_PUBLIC_KEY="<YOUR_PUBLIC_KEY>"`
    -  `export MONGODB_ATLAS_PRIVATE_KEY="<YOUR_PRIVATE_KEY>"`
    -  `export AWS_ACCESS_KEY_ID="<YOUR_ACCESS_KEY>"`
    -  `export AWS_SECRET_ACCESS_KEY="<YOUR_SECRET_KEY>"`
    -  `export AWS_REGION="<YOUR_REGION>"`

- Run the following command to initialize your project:

```bash
$ terraform init
```

- Run the following command to review the execution plan:

```bash
$ terraform plan
```

- Run the following command to deploy your infrastructure:

```bash
$ terraform apply
```

## Considerations

- Your AWS KMS Key policy should allow the IAM Role access. The following is an example of how to provide this permission:

```terraform
{
  "Statement": [
      // other statements
      {
          "Sid": "Allow use of the key by specific IAM user",
          "Action": [
              "kms:Decrypt",
              "kms:Encrypt",
              "kms:DescribeKey"
          ],
          "Effect": "Allow",
          "Principal": {
              "AWS": "*"
          },
          "Resource": "*",
          "Condition": {
              "StringEquals": {
                  "aws:PrincipalArn": "arn:aws:iam::{ACCOUNT}:role/IAM_EXECUTION_ROLE"
              }
          }
      }
  ],
  "Version": "2012-10-17"
}
```

_Note: the IAM Role ARN used in the aws:PrincipalArn attribute is the one created in the submodule._

- If you want more information on how to enable encryption at rest in your cluster, refer to this [blog post](https://www.mongodb.com/docs/atlas/security-kms-encryption/).

## Resources

The module creates the following resources:

| Name | Type |
|------|------|
| [aws_kms_key](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/kms_key) | data source |
| [mongodbatlas_encryption_at_rest](https://registry.terraform.io/providers/mongodb/mongodbatlas/1.17.6/docs/resources/encryption_at_rest) | resource |
| [mongodbatlas_cloud_provider_access_setup](https://registry.terraform.io/providers/mongodb/mongodbatlas/latest/docs/resources/cloud_provider_access#mongodbatlas_cloud_provider_access_setup) | resource |
| [mongodbatlas_cloud_provider_access_authorization](https://registry.terraform.io/providers/mongodb/mongodbatlas/latest/docs/resources/cloud_provider_access#mongodbatlas_cloud_provider_access_authorization) | resource |
| [aws_iam_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
