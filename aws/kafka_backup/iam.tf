
data "aws_caller_identity" "this" {}
data "aws_region" "this" {}

resource "aws_iam_role_policy_attachment" "backup" {
  policy_arn = aws_iam_policy.backup.arn
  role       = aws_iam_role.backup.name
}

resource "aws_iam_role" "backup" {
  name = replace(title("${var.resources_prefix}-msk-bkp-role"), "-", "")

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

resource "aws_iam_policy" "backup" {
  name = replace(title("${var.resources_prefix}-msk-bkp-policy"), "-", "")

  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : [
          "s3:ListAllMyBuckets"
        ],
        "Resource" : "arn:aws:s3:::*"
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "s3:ListBucket",
          "s3:GetBucketLocation"
        ],
        "Resource" : "arn:aws:s3:::${local.bucket_name}"
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "s3:PutObject",
          "s3:GetObject",
          "s3:AbortMultipartUpload",
          "s3:PutObjectTagging"
        ],
        "Resource" : "arn:aws:s3:::${local.bucket_name}/*"
      },
      # See https://repost.aws/knowledge-center/msk-connector-connect-errors for the below rules
      {
        "Effect" : "Allow",
        "Action" : [
          "kafka-cluster:Connect",
          "kafka-cluster:DescribeCluster"
        ],
        "Resource" : [
          var.msk_cluster.arn
        ]
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "kafka-cluster:ReadData",
          "kafka-cluster:DescribeTopic"
        ],
        "Resource" : [
          "*"
        ]
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "kafka-cluster:WriteData",
          "kafka-cluster:DescribeTopic"
        ],
        "Resource" : [
          "*"
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
          "*"
        ]
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "kafka-cluster:AlterGroup",
          "kafka-cluster:DescribeGroup"
        ],
        "Resource" : [
          "*"
        ]
      }
    ]
  })
}
