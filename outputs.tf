output "github_actions_aws_iam_role_to_assume" {
  value = aws_iam_role.github_oidc.arn
}
