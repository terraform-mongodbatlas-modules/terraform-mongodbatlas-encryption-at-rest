resource "random_string" "this" {
  length  = 5
  special = false
  numeric = false
  upper   = false
}

locals {
  random_suffix            = random_string.this.result
  iam_role_name_def        = var.iam_role_name == null ? "${var.project_id}-atlas-encryption-at-rest-role-${local.random_suffix}" : var.iam_role_name
  iam_role_policy_name_def = var.iam_role_policy_name == null ? "${var.project_id}-atlas-encryption-at-rest-policy-${local.random_suffix}" : var.iam_role_policy_name
}

data "aws_kms_key" "kms_key_data" {
  key_id = var.aws_kms_key_arn
}

resource "aws_iam_role" "iam_role" {
  name                 = local.iam_role_name_def
  assume_role_policy = <<EOF
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Principal": {
          "AWS": "${mongodbatlas_cloud_provider_access_setup.setup.aws_config[0].atlas_aws_account_arn}"
        },
        "Action": "sts:AssumeRole",
        "Condition": {
          "StringEquals": {
            "sts:ExternalId": "${mongodbatlas_cloud_provider_access_setup.setup.aws_config[0].atlas_assumed_role_external_id}"
          }
        }
      }
    ]
  }
  EOF
}

resource "aws_iam_role_policy" "policy" {
  name = local.iam_role_policy_name_def
  role = aws_iam_role.iam_role.id

  policy = <<-EOF
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Action": [
          "kms:Decrypt",
          "kms:Encrypt",
          "kms:DescribeKey"
        ],
        "Resource": [
          "${data.aws_kms_key.kms_key_data.arn}"
        ]
      }
    ]
  }
  EOF
}

resource "mongodbatlas_cloud_provider_access_setup" "setup" {
  project_id    = var.project_id
  provider_name = "AWS"
}

resource "mongodbatlas_cloud_provider_access_authorization" "auth" {
  project_id = var.project_id
  role_id    = mongodbatlas_cloud_provider_access_setup.setup.role_id

  aws {
    iam_assumed_role_arn = aws_iam_role.iam_role.arn
  }
}

resource "mongodbatlas_encryption_at_rest" "encryption" {
  project_id = var.project_id

  aws_kms_config {
    enabled = true
    customer_master_key_id = data.aws_kms_key.kms_key_data.id
    region = var.kms_key_region
    role_id = mongodbatlas_cloud_provider_access_authorization.auth.role_id
  } 
}
