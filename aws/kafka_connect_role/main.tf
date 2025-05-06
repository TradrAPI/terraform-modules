resource "aws_iam_role_policy_attachment" "this" {
  role       = aws_iam_role.this.name
  policy_arn = aws_iam_policy.kafka_iam_auth.arn
}

resource "aws_iam_role" "this" {
  name = var.role_name

  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Service" : "kafkaconnect.amazonaws.com"
        },
        "Action" : "sts:AssumeRole"
        "Condition" : {
          "StringEquals" : {
            "aws:SourceAccount" : data.aws_caller_identity.this.account_id
          }
        }
      }
    ]
  })
}

resource "aws_iam_policy" "kafka_iam_auth" {
  name = replace(title("${var.role_name}-kafka-iam-auth"), "-", "")

  description = "IAM policy for Kafka Connect to authenticate with MSK using IAM"

  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : [
          "kafka-cluster:Connect",
          "kafka-cluster:DescribeCluster"
        ],
        "Resource" : [
          "arn:aws:kafka:${data.aws_region.this.name}:${data.aws_caller_identity.this.account_id}:cluster/${var.cluster_name}/${var.cluster_id}"
        ]
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "kafka-cluster:ReadData",
          "kafka-cluster:DescribeTopic"
        ],
        "Resource" : [
          "arn:aws:kafka:${data.aws_region.this.name}:${data.aws_caller_identity.this.account_id}:topic/${var.cluster_name}/${var.cluster_id}/__amazon_msk_connect_read"
        ]
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "kafka-cluster:WriteData",
          "kafka-cluster:DescribeTopic"
        ],
        "Resource" : [
          "arn:aws:kafka:${data.aws_region.this.name}:${data.aws_caller_identity.this.account_id}:topic/${var.cluster_name}/${var.cluster_id}/__amazon_msk_connect_write"
        ]
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "kafka-cluster:CreateTopic",
          "kafka-cluster:WriteData",
          "kafka-cluster:ReadData",
          "kafka-cluster:DescribeTopic"
        ],
        "Resource" : [
          "arn:aws:kafka:${data.aws_region.this.name}:${data.aws_caller_identity.this.account_id}:topic/${var.cluster_name}/${var.cluster_id}/__amazon_msk_connect_*"
        ]
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "kafka-cluster:AlterGroup",
          "kafka-cluster:DescribeGroup"
        ],
        "Resource" : [
          "arn:aws:kafka:${data.aws_region.this.name}:${data.aws_caller_identity.this.account_id}:group/${var.cluster_name}/${var.cluster_id}/__amazon_msk_connect_*",
          "arn:aws:kafka:${data.aws_region.this.name}:${data.aws_caller_identity.this.account_id}:group/${var.cluster_name}/${var.cluster_id}/connect-*"
        ]
      }
    ]
  })
}
