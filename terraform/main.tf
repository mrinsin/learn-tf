resource "aws_s3_bucket" "my_website_bucket" {
  bucket = "my-example-website.flexion.us"
  acl    = "public-read"

  website {
    index_document = "index.html"
    error_document = "index.html"

    routing_rules = <<EOF
[{
    "Condition": {
        "KeyPrefixEquals": "docs/"
    },
    "Redirect": {
        "ReplaceKeyPrefixWith": "documents/"
    }
}]
EOF
  }
}

resource "aws_s3_bucket_policy" "my_website_bucket_policy" {
  bucket = "${aws_s3_bucket.my_website_bucket.id}"

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Id": "my_website_bucket_policy_id",
  "Statement": [
    {
      "Sid": "IPAllow",
      "Effect": "Allow",
      "Principal": "*",
      "Action": "s3:GetObject",
      "Resource": "arn:aws:s3:::my-example-website.flexion.us/*"
    }
  ]
}
POLICY
}