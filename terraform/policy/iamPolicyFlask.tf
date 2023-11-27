# rlatkdFlask Authority
resource "aws_iam_policy" "iamPolicyFlask" {
  name        = "iamPolicyFlask"
  path        = "/"
  description = "policy for rlatkdFlask"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [

      # AmazonEC2FullAccess
      {
        "Action" : "ec2:*",
        "Effect" : "Allow",
        "Resource" : "*"
      },
      {
        "Effect" : "Allow",
        "Action" : "elasticloadbalancing:*",
        "Resource" : "*"
      },
      {
        "Effect" : "Allow",
        "Action" : "cloudwatch:*",
        "Resource" : "*"
      },
      {
        "Effect" : "Allow",
        "Action" : "autoscaling:*",
        "Resource" : "*"
      },
      {
        "Effect" : "Allow",
        "Action" : "iam:CreateServiceLinkedRole",
        "Resource" : "*",
        "Condition" : {
          "StringEquals" : {
            "iam:AWSServiceName" : [
              "autoscaling.amazonaws.com",
              "ec2scheduled.amazonaws.com",
              "elasticloadbalancing.amazonaws.com",
              "spot.amazonaws.com",
              "spotfleet.amazonaws.com",
              "transitgateway.amazonaws.com"
            ]
          }
        }
      },

      # AmazonS3FullAccess
      {
        "Effect" : "Allow",
        "Action" : [
          "s3:*",
          "s3-object-lambda:*"
        ],
        "Resource" : "*"
      },

      # AWSCodeDeployFullAccess
      {
        "Action" : "codedeploy:*",
        "Effect" : "Allow",
        "Resource" : "*"
      },
      {
        "Sid" : "CodeStarNotificationsReadWriteAccess",
        "Effect" : "Allow",
        "Action" : [
          "codestar-notifications:CreateNotificationRule",
          "codestar-notifications:DescribeNotificationRule",
          "codestar-notifications:UpdateNotificationRule",
          "codestar-notifications:DeleteNotificationRule",
          "codestar-notifications:Subscribe",
          "codestar-notifications:Unsubscribe"
        ],
        "Resource" : "*",
        "Condition" : {
          "StringLike" : {
            "codestar-notifications:NotificationsForResource" : "arn:aws:codedeploy:*"
          }
        }
      },
      {
        "Sid" : "CodeStarNotificationsListAccess",
        "Effect" : "Allow",
        "Action" : [
          "codestar-notifications:ListNotificationRules",
          "codestar-notifications:ListTargets",
          "codestar-notifications:ListTagsforResource",
          "codestar-notifications:ListEventTypes"
        ],
        "Resource" : "*"
      },
      {
        "Sid" : "CodeStarNotificationsSNSTopicCreateAccess",
        "Effect" : "Allow",
        "Action" : [
          "sns:CreateTopic",
          "sns:SetTopicAttributes"
        ],
        "Resource" : "arn:aws:sns:*:*:codestar-notifications*"
      },
      {
        "Sid" : "CodeStarNotificationsChatbotAccess",
        "Effect" : "Allow",
        "Action" : [
          "chatbot:DescribeSlackChannelConfigurations"
        ],
        "Resource" : "*"
      },
      {
        "Sid" : "SNSTopicListAccess",
        "Effect" : "Allow",
        "Action" : [
          "sns:ListTopics"
        ],
        "Resource" : "*"
      }
    ]
  })
}
