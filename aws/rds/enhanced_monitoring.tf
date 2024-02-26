data "aws_iam_role" "enhanced_monitoring" {
  count = var.create_monitoring_role ? 0 : 1

  name = var.monitoring_role
}

resource "aws_iam_role" "enhanced_monitoring" {
  count = var.create_monitoring_role ? 1 : 0

  name               = var.monitoring_role
  assume_role_policy = data.aws_iam_policy_document.enhanced_monitoring[0].json
}

data "aws_iam_policy_document" "enhanced_monitoring" {
  count = var.create_monitoring_role ? 1 : 0

  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["monitoring.rds.amazonaws.com"]
    }
  }
}

resource "aws_iam_role_policy_attachment" "enhanced_monitoring-attach" {
  count      = var.create_monitoring_role ? 1 : 0
  role       = aws_iam_role.enhanced_monitoring[0].name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonRDSEnhancedMonitoringRole"
}
