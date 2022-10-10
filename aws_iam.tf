data "tls_certificate" "github" {
  url = "https://token.actions.githubusercontent.com/.well-known/openid-configuration"
}

resource "aws_iam_openid_connect_provider" "github" {
  url = "https://token.actions.githubusercontent.com"

  client_id_list = ["sts.amazonaws.com"]

  thumbprint_list = [data.tls_certificate.github.certificates[0].sha1_fingerprint]
}

data "aws_iam_policy_document" "github_oidc" {
  statement {
    effect = "Allow"

    principals {
      type        = "Federated"
      identifiers = [aws_iam_openid_connect_provider.github.arn]
    }

    actions = [
      "sts:AssumeRoleWithWebIdentity"
    ]

    # Restrict access to the georgewitteman/terraform repository.
    condition {
      test = "StringLike"
      # sub: subject
      variable = "token.actions.githubusercontent.com:sub"
      values   = ["repo:georgewitteman/terraform*"]
    }

    # The below conditions are probably unnecessary. They're copied from
    # GitHub's docs:
    # https://docs.github.com/en/actions/deployment/security-hardening-your-deployments/configuring-openid-connect-in-amazon-web-services#configuring-the-role-and-trust-policy

    # Restrict access to only GitHub actions.
    condition {
      test = "ForAllValues:StringEquals"
      # iss: issuer - The issuer of the OIDC token
      variable = "token.actions.githubusercontent.com:iss"
      values   = ["https://token.actions.githubusercontent.com"]
    }

    # Restrict access to the standard AWS credentials action.
    # https://github.com/aws-actions/configure-aws-credentials/blob/5a4b8f03d1948e564e5e97d168d19dbbab75abf4/action.yml#L8
    condition {
      test = "ForAllValues:StringEquals"
      # aud: audience
      variable = "token.actions.githubusercontent.com:aud"
      values   = ["sts.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "github_oidc" {
  name                = "GitHubActionsOIDC"
  assume_role_policy  = data.aws_iam_policy_document.github_oidc.json
  managed_policy_arns = ["arn:aws:iam::aws:policy/AdministratorAccess"]
}
