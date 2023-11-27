module "iam_policy_code_deploy" {
  source = "../authority/rlatkdCodeDeployEC2Policy.tf"
}

# rlatkdEC2AccessS3Role
resource "aws_iam_role" "rlatkdEC2AccessS3Role" {
  name = "rlatkdEC2AccessS3Role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "sts:AssumeRole",
      Effect = "Allow",
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
  })
}

resource "aws_iam_policy_attachment" "attach_policy_to_role" {
  name       = "rlatkdEC2AccessS3Role-attachment"
  roles      = [aws_iam_role.rlatkdEC2AccessS3Role.name]
  policy_arn = module.iam_policy_code_deploy.arn
}
