provider "aws" {
  access_key = "${var.accesskey}"
  secret_key = "${var.secretkey}"
  region     = "${var.location}"
}
resource "aws_s3_bucket" "smartshop-ecom" {
  bucket = "smartshop-ecom"
  acl    = "private"
}

resource "aws_iam_role" "satya" {
  name = "satya"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "codebuild.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "satya" {
  role        = "${aws_iam_role.satya.name}"

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Resource": [
        "*"
      ],
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ]
    },
    {
      "Effect": "Allow",
      "Action": [
        "ec2:CreateNetworkInterface",
        "ec2:DescribeDhcpOptions",
        "ec2:DescribeNetworkInterfaces",
        "ec2:DeleteNetworkInterface",
        "ec2:DescribeSubnets",
        "ec2:DescribeSecurityGroups",
        "ec2:DescribeVpcs"
      ],
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": [
        "s3:*"
      ],
      "Resource": [
        "${aws_s3_bucket.smartshop-ecom.arn}",
        "${aws_s3_bucket.smartshop-ecom.arn}/*"
      ]
    }
  ]
}
POLICY
}

resource "aws_codebuild_project" "javaproject-smartshop" {
  name         = "test-project"
  description  = "test_codebuild_project"
  build_timeout      = "5"
  service_role = "${aws_iam_role.satya.arn}"

  artifacts {
    type = "NO_ARTIFACTS"
  }

  cache {
    type     = "S3"
    location = "${aws_s3_bucket.smartshop-ecom.bucket}"
  }

  environment {
    compute_type = "BUILD_GENERAL1_SMALL"
    image        = "aws/codebuild/smartshop:2.0"
    type         = "LINUX_CONTAINER"

    environment_variable {
      "name"  = "murali"
      "value" = "12345678"
    }
  }

  source {
    type            = "GITHUB"
    location        = "${var.github}"
    git_clone_depth = 1
  }

  vpc_config {
    vpc_id = "${var.vpc}"

    subnets = [
      "${var.subnet1}",
      "${var.subnet2}",
    ]

    security_group_ids = [ "${var.securitygroup}"
    ]
  }

  tags {
    "Environment" = "Test"
  }
}
