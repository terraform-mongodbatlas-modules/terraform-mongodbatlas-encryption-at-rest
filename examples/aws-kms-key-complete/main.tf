resource "aws_kms_key" "key" {
  description = "MongoDB Atlas KMS key."
}

module "aws-kms-key" {
  source               = "../../modules/aws-kms"
  project_id           = var.project_id
  aws_kms_key_arn      = aws_kms_key.key.arn
  iam_role_name        = "iam-role-example-name"
  iam_role_policy_name = "iam-role-policy-example-name"
  kms_key_region       = "US_EAST_2" # assuming the KMS key was created in AWS region us-east-2
}

resource "mongodbatlas_advanced_cluster" "cluster" {
  project_id                  = var.project_id
  name                        = "MyCluster"
  cluster_type                = "REPLICASET"
  backup_enabled              = true
  encryption_at_rest_provider = "AWS"

  replication_specs {
    region_configs {
      priority      = 7
      provider_name = "AWS"
      region_name   = "US_EAST_2"
      electable_specs {
        instance_size = "M10"
        node_count    = 3
      }
    }
  }
}
