# rlatkdReact 사용자
resource "aws_iam_user" "rlatkdReact" {
  name = "rlatkdReact"
}

module "iam_policy_react" {
  source = "../authority/iamPolicyReact.tf"
}

resource "aws_iam_user_policy_attachment" "attach_policy_to_user" {
  user       = aws_iam_user.rlatkReact_user.name
  policy_arn = module.iam_policy_react.arn
}


# rlatkdFlask 사용자
resource "aws_iam_user" "rlatkdFlask" {
  name = "rlatkdFlask"
}

module "iam_policy_flask" {
  source = "../authority/iamPolicyFlask.tf"
}

resource "aws_iam_user_policy_attachment" "attach_policy_to_user" {
  user       = aws_iam_user.rlatkFlask_user.name
  policy_arn = module.iam_policy_flask.arn
}


# rlatkdMySQL 사용자
resource "aws_iam_user" "rlatkdMySQL" {
  name = "rlatkdMysQL"
}

module "iam_policy_mysql" {
  source = "../authority/iamPolicyMySQL.tf"
}

resource "aws_iam_user_policy_attachment" "attach_policy_to_user" {
  user       = aws_iam_user.rlatkMySQL_user.name
  policy_arn = module.iam_policy_mysql.arn
}
