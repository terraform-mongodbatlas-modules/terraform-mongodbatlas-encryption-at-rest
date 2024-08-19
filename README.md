# Encryption At Rest Terraform Module

This Terraform module sets up [encryption at rest](https://www.mongodb.com/docs/atlas/security-kms-encryption/) using Customer Key Management for your [MongoDB Atlas](https://www.mongodb.com/products/platform/atlas-database) Project and consists of an [AWS KMS Key](https://github.com/terraform-mongodbatlas-modules/terraform-mongodbatlas-encryption-at-rest/tree/main/modules/aws-kms).

## Requirements

- [Terraform](https://developer.hashicorp.com/terraform/install) >= 1.0
- [terraform-provider-mongodbatlas](https://registry.terraform.io/providers/mongodb/mongodbatlas/latest/docs)
- [terraform-provider-aws](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
- [MongoDB Atlas](https://www.mongodb.com/products/platform/atlas-database) account
- [AWS](https://aws.amazon.com/account/) account
