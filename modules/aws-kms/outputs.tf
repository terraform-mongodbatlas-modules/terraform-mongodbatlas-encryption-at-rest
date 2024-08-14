# aws_iam_role

output "role_arn" {
  description = "Amazon Resource Name (ARN) specifying the role."
  value       = aws_iam_role.iam_role.arn
}

output "unique_id" {
  description = "Stable and unique string identifying the role."
  value       = aws_iam_role.iam_role.unique_id
}

# aws_iam_role_policy

output "role_policy_id" {
  description = "The role policy ID, in the form of role_name:role_policy_name."
  value       = aws_iam_role_policy.policy.id
}
