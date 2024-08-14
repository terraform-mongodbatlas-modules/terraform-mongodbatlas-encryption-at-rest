provider "mongodbatlas" {
}

provider "aws" {
  region = "us-east-2"
}

run "generate_random_name" {
  module {
    source = "./tests/random_name_generator"
  }
}

run "create_project" {
  module {
    source = "./tests/project_generator"
  }

  variables {
    project_name = "test-modules-tf-p-${run.generate_random_name.name_project}"
  }
}

run "enable_encryption_at_rest_aws_kms_key" {
  command = apply

  module {
    source = "./"
  }

  variables {
    project_id           = run.create_project.project_id
    aws_kms_key_arn      = "arn:aws:kms:us-east-2:358363220050:key/b6a1d91b-59ad-4cb8-9d15-64175ab4791b"
    iam_role_name        = "mongodb-atlas-test-acc-tf-${run.create_project.project_id}"
    iam_role_policy_name = "mongodb-atlas-test-acc-tf-${run.create_project.project_id}"
    kms_key_region       = "US_EAST_2"
  }

  assert {
    condition     = aws_iam_role.iam_role.name == "test-modules-tf-role-${run.create_project.project_id}"
    error_message = "Invalid role name"
  }

  assert {
    condition     = aws_iam_role_policy.policy.name == "test-modules-tf-policy-${run.create_project.project_id}"
    error_message = "Invalid policy name"
  }

  assert {
    condition     = mongodbatlas_encryption_at_rest.encryption.id == run.create_project.project_id
    error_message = "Encryption went wrong: ID does not coincide with Project ID."
  }
}
