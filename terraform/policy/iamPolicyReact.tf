# rlatkdReact Authority
resource "aws_iam_policy" "iamPolicyReact" {
  name        = "iamPolicyReact"
  path        = "/"
  description = "policy for rlatkdReact"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [

      # AmazonS3FullAccess
      {
        "Effect" : "Allow",
        "Action" : [
          "s3:*",
          "s3-object-lambda:*"
        ],
        "Resource" : "*"
      }
    ]
  })
}
