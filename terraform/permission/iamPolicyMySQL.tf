# rlatkdMySQL Authority
resource "aws_iam_policy" "iamPolicyMySQL" {
  name        = "iamPolicyMySQL"
  path        = "/"
  description = "policy for rlatkdMySQL"
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

      # AmazonRDSFullAccess
      {
        "Effect" : "Allow",
        "Action" : [
          "rds:*",
          "application-autoscaling:DeleteScalingPolicy",
          "application-autoscaling:DeregisterScalableTarget",
          "application-autoscaling:DescribeScalableTargets",
          "application-autoscaling:DescribeScalingActivities",
          "application-autoscaling:DescribeScalingPolicies",
          "application-autoscaling:PutScalingPolicy",
          "application-autoscaling:RegisterScalableTarget",
          "cloudwatch:DescribeAlarms",
          "cloudwatch:GetMetricStatistics",
          "cloudwatch:PutMetricAlarm",
          "cloudwatch:DeleteAlarms",
          "cloudwatch:ListMetrics",
          "cloudwatch:GetMetricData",
          "ec2:DescribeAccountAttributes",
          "ec2:DescribeAvailabilityZones",
          "ec2:DescribeCoipPools",
          "ec2:DescribeInternetGateways",
          "ec2:DescribeLocalGatewayRouteTablePermissions",
          "ec2:DescribeLocalGatewayRouteTables",
          "ec2:DescribeLocalGatewayRouteTableVpcAssociations",
          "ec2:DescribeLocalGateways",
          "ec2:DescribeSecurityGroups",
          "ec2:DescribeSubnets",
          "ec2:DescribeVpcAttribute",
          "ec2:DescribeVpcs",
          "ec2:GetCoipPoolUsage",
          "sns:ListSubscriptions",
          "sns:ListTopics",
          "sns:Publish",
          "logs:DescribeLogStreams",
          "logs:GetLogEvents",
          "outposts:GetOutpostInstanceTypes",
          "devops-guru:GetResourceCollection"
        ],
        "Resource" : "*"
      },
      {
        "Effect" : "Allow",
        "Action" : "pi:*",
        "Resource" : [
          "arn:aws:pi:*:*:metrics/rds/*",
          "arn:aws:pi:*:*:perf-reports/rds/*"
        ]
      },
      {
        "Effect" : "Allow",
        "Action" : "iam:CreateServiceLinkedRole",
        "Resource" : "*",
        "Condition" : {
          "StringLike" : {
            "iam:AWSServiceName" : [
              "rds.amazonaws.com",
              "rds.application-autoscaling.amazonaws.com"
            ]
          }
        }
      },
      {
        "Action" : [
          "devops-guru:SearchInsights",
          "devops-guru:ListAnomaliesForInsight"
        ],
        "Effect" : "Allow",
        "Resource" : "*",
        "Condition" : {
          "ForAllValues:StringEquals" : {
            "devops-guru:ServiceNames" : [
              "RDS"
            ]
          },
          "Null" : {
            "devops-guru:ServiceNames" : "false"
          }
        }
      }
    ]
  })
}
