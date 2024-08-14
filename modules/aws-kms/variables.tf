variable "project_id" {
  description = "The project id (e.g., 65def6ce0f722a1507105bb5)."
  type        = string
}

variable "iam_role_name" {
  description = "Name of the IAM role to use to set up cloud provider access in Atlas. If you provide no value, a default value of the form {project_id}-atlas-encryption-at-rest-role-{random_string} is assigned (e.g., 66a7ae173df3c34412a71cd6-atlas-encryption-at-rest-role-asdfg)."
  type        = string
  default     = null
  nullable    = true
}

variable "iam_role_policy_name" {
  description = "Name of the IAM role policy for the configured aws_iam_role_name. If you provide no value, a default value of the form {project_id}-atlas-encryption-at-rest-policy-{random_string} is assigned (e.g., 66a7ae173df3c34412a71cd6-atlas-encryption-at-rest-policy-asdfg)."
  type        = string
  default     = null
  nullable    = true
}

variable "aws_kms_key_arn" {
  description = "The ARN of the AWS KMS key (e.g., arn:aws:kms:us-east-1:111122223333:key/1234abcd-12ab-34cd-56ef-1234567890ab)."
  type        = string
}

variable "kms_key_region" {
  description = "The AWS region in which the AWS customer master key exists: CA_CENTRAL_1, US_EAST_1, US_EAST_2, US_WEST_1, US_WEST_2, SA_EAST_1."
  type        = string
}
