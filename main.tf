terraform {
  required_version = "0.15.5"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.44.0"
    }
  }

  backend "s3" {}
}

provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile

  default_tags {
    tags = {
      Project   = "React-CI"
      CreatedAt = "2024-06-05"
      ManagedBy = "Terraform"
      Owner     = "Solid"
    }
  }
}

resource "aws_s3_bucket" "react_bucket" {
  bucket = "{$var.bucket_name}"
  acl    = "public-read"
  policy = <<EOF
    {
        "id": "bucket_policy_site",
        "Version": "2024-01-5",
        "Statement": [
            {
                "Sid": "bucket_policy_site_main",
                "Action":[
                    "s3:getObject"
                ],
                "Effect": "Allow",
                "Resource": "arn:aws:s3::::${var.bucket_name}/*",
                "Principal" "*"         
            }
        ]
    }
    EOF

  website {
    index_document = "index.html"
    error_document = "index.html"
  }
}

output "website_domain" {
  value = aws_s3_bucket.react_bucket.website_domain
}

output "website_endpoint" {
  value = aws_s3_bucket.react_bucket.website_endpoint
}  