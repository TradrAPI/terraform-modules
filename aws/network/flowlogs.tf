resource "aws_flow_log" "default" {
  count = var.flowlogs ? 1 : 0

  iam_role_arn         = aws_iam_role.flowlog[0].arn
  log_destination      = aws_cloudwatch_log_group.flowlogs[0].arn
  log_destination_type = "cloud-watch-logs"
  traffic_type         = "ALL"
  vpc_id               = aws_vpc.default.id

  tags = {
    Name = "${var.name}-vpc-flowlogs"
  }
}

resource "aws_cloudwatch_log_group" "flowlogs" {
  count = var.flowlogs ? 1 : 0

  name              = "${var.name}-flowlogs"
  retention_in_days = 7
}

resource "aws_iam_role" "flowlog" {
  count = var.flowlogs ? 1 : 0

  name = try(var.name_overrides.flowlogs_role, "${var.name}-flowlog-role")

  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Action" : "sts:AssumeRole",
        "Principal" : {
          "Service" : "vpc-flow-logs.amazonaws.com"
        },
        "Effect" : "Allow",
        "Sid" : ""
      }
    ]
  })
}

resource "aws_iam_policy" "flowlog" {
  count = var.flowlogs ? 1 : 0

  name = try(var.name_overrides.flowlogs_policy, "${var.name}-flowlog-policy")

  description = "Policy for VPC flow logs"

  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Sid" : "VPCFlowLogsAccess",
        "Effect" : "Allow",
        "Action" : [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:DescribeLogGroups",
          "logs:DescribeLogStreams",
          "logs:PutLogEvents"
        ],
        "Resource" : "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "flow_log_policy_attachment" {
  count = var.flowlogs ? 1 : 0

  role       = aws_iam_role.flowlog[0].name
  policy_arn = aws_iam_policy.flowlog[0].arn
}
