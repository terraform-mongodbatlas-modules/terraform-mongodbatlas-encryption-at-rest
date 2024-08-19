# AWS KMS Key Terraform Submodule

This Terraform submodule sets up [encryption at rest](https://www.mongodb.com/docs/atlas/security-kms-encryption/) using an AWS KMS Key for your [MongoDB Atlas](https://www.mongodb.com/products/platform/atlas-database) Project.

It creates the resources to perform the following actions:

- Set up Access to Cloud Provider for MongoDB Atlas.
- Create an AWS IAM Role.
- Create an AWS IAM Role Policy.
- Authorize MongoDB Atlas for Cloud Provider Access.
- Enable Encryption at Rest in the Atlas project.

You can find detailed information of the submodule's input and output variables in the [Terraform Public Registry]()

## Usage 

```terraform
module "aws-kms-key" {
  source  = "terraform-mongodbatlas-modules/encryption-at-rest/mongodbatlas//modules/aws-kms"
  project_id = "66a26b4c85718b1be4ff37cb"
  aws_kms_key_arn = "arn:aws:kms:us-east-1:111122223333:key/1234abcd-12ab-34cd-56ef-1234567890ab"       
  iam_role_name = "encryption-at-rest-role"
  iam_role_policy_name = "encryption-at-rest-policy"
  kms_key_region = "US_EAST_1"
}
```

The [examples](https://github.com/terraform-mongodbatlas-modules/terraform-mongodbatlas-encryption-at-rest/tree/main/examples) folder contains a detailed example that shows how to use this submodule.

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

-> **NOTE:** Encryption at rest can only be enabled once per project.

For more information, see the [MongoDB Atlas](https://registry.terraform.io/providers/mongodb/mongodbatlas/latest/docs) and [AWS](https://registry.terraform.io/providers/hashicorp/aws/latest/docs) Terraform providers documentation.

## License

See [LICENSE](https://github.com/terraform-mongodbatlas-modules/terraform-mongodbatlas-encryption-at-rest/blob/main/LICENSE) for full details.
