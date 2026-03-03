# Encryption At Rest Terraform Module

# This module has been deprecated

This repository is no longer maintained. Its functionality has been superseded by the [MongoDB Atlas AWS Module](https://registry.terraform.io/modules/terraform-mongodbatlas-modules/atlas-aws/mongodbatlas/latest) (`terraform-mongodbatlas-modules/atlas-aws/mongodbatlas`), which provides encryption at rest with AWS KMS along with additional AWS integrations including PrivateLink, cloud provider access, and backup export to S3.

## Migration

Replace your module source:

```hcl
# Before
module "aws-kms-key" {
  source  = "terraform-mongodbatlas-modules/encryption-at-rest/mongodbatlas//modules/aws-kms"
  project_id = var.project_id
  aws_kms_key_arn = var.aws_kms_key_arn
  iam_role_name = "encryption-at-rest-role"
  iam_role_policy_name = "encryption-at-rest-policy"
  kms_key_region = "US_EAST_1"
}

# After
module "atlas_aws" {
  source  = "terraform-mongodbatlas-modules/atlas-aws/mongodbatlas"
  project_id = var.project_id

  encryption = {
    enabled = true
    create_kms_key = {
      enabled = true
    }
  }
}
```

For additional encryption configurations (private endpoints for KMS, BYOK), see the [atlas-aws examples](https://github.com/terraform-mongodbatlas-modules/terraform-mongodbatlas-atlas-aws/tree/main/examples).

## Links

- [atlas-aws on Terraform Registry](https://registry.terraform.io/modules/terraform-mongodbatlas-modules/atlas-aws/mongodbatlas/latest)
- [atlas-aws on GitHub](https://github.com/terraform-mongodbatlas-modules/terraform-mongodbatlas-atlas-aws)

# Old Docs
This Terraform module sets up [encryption at rest](https://www.mongodb.com/docs/atlas/security-kms-encryption/) using Customer Key Management for your [MongoDB Atlas](https://www.mongodb.com/products/platform/atlas-database) Project and consists of an [AWS KMS Key](https://github.com/terraform-mongodbatlas-modules/terraform-mongodbatlas-encryption-at-rest/tree/main/modules/aws-kms).

## Requirements

- [Terraform](https://developer.hashicorp.com/terraform/install) >= 1.0
- [terraform-provider-mongodbatlas](https://registry.terraform.io/providers/mongodb/mongodbatlas/latest/docs)
- [terraform-provider-aws](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
- [MongoDB Atlas](https://www.mongodb.com/products/platform/atlas-database) account
- [AWS](https://aws.amazon.com/account/) account
