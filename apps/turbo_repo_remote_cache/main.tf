module "lambda" {
  source  = "terraform-aws-modules/lambda/aws"
  version = "7.2.5"

  publish     = true
  create_role = true

  policy_json = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : [
          "s3:*"
        ],
        "Resource" : [
          "arn:aws:s3:::${module.bucket.bucket_id}",
          "arn:aws:s3:::${module.bucket.bucket_id}/*"
        ]
      }
    ]
  })

  function_name      = var.name
  logging_log_group  = "/aws/lambda/${var.name}-0"
  attach_policy_json = true

  timeout = var.timeout

  handler = "dist/index.handler"
  runtime = "nodejs18.x"

  source_path = [{
    path = "${path.module}/lambda"

    commands = concat(var.pre_commands, [
      "npm install",
      "npm run build",
      ":zip"
    ])
  }]

  create_lambda_function_url = true
  authorization_type         = "NONE"

  cors = {
    allow_origins = ["*"]
    allow_headers = ["*"]
    allow_methods = ["*"]
  }

  environment_variables = merge({
    STORAGE_PATH     = module.bucket.bucket_id
    STORAGE_PROVIDER = "s3"
    TURBO_TOKEN      = random_password.turbo_token.result
    }, {
    for k, v in var.extra_environment_variables :
    k => v
    if !contains(["STORAGE_PATH", "STORAGE_PROVIDER", "TURBO_TOKEN"], k)
  })

  depends_on = [
    module.bucket
  ]
}

resource "random_password" "turbo_token" {
  length = 32
}

module "bucket" {
  source = "../../aws/s3"

  bucket_name = var.name

  lifetime_days     = 7
  create_bucket_acl = false
  force_destroy     = true
}
