provider "aws" {
  region = "eu-west-1"
}

variable "bucket-name" {
  default = "IP-bucket"
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