# rlatkdCodeDeployEC2Policy
resource "aws_iam_policy" "iamPolicyReact" {
  name        = "iamPolicyReact"
  path        = "/"
  description = "policy for rlatkdReact"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [

      # rlatkdCodeDeployEC2Policy
      {
        "Sid" : "Statement1",
        "Effect" : "Allow",
        "Action" : [
          "s3:Get*",
          "s3:List*"
        ],
        "Resource" : "*"
      }
    ]
  })
}
