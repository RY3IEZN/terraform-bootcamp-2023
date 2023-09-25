# create random string
resource "random_string" "bucket_name" {
  length  = 16
  upper   = false
  special = false
}


# create the teratown bucket
resource "aws_s3_bucket" "teratown_bucket" {
  bucket = random_string.bucket_name.result

  tags = {
    name = var.tagname
  }
}

# create the teratown website config
resource "aws_s3_bucket_website_configuration" "teratown_website_config" {
  bucket = aws_s3_bucket.teratown_bucket.bucket

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }

}

# create index.html object inside bucket
resource "aws_s3_object" "index_html_object" {
  bucket       = aws_s3_bucket.teratown_bucket.bucket
  key          = "index.html"
  source       = "${path.root}/public/index.html"
  content_type = "text/html"

  etag = filemd5("${path.root}/public/index.html")

  lifecycle {
    replace_triggered_by = [terraform_data.content_version.output]
    ignore_changes       = [etag]
  }
}

# create error.html object inside bucket
resource "aws_s3_object" "error_html_object" {
  bucket       = aws_s3_bucket.teratown_bucket.bucket
  key          = "error.html"
  source       = "${path.root}/public/error.html"
  content_type = "text/html"

  etag = filemd5("${path.root}/public/error.html")
}

# create the bucket policy
resource "aws_s3_bucket_policy" "terratown_bucket_policy" {
  bucket = aws_s3_bucket.teratown_bucket.bucket
  # policy = data.aws_iam_policy_document.allow_access_from_another_account.json
  policy = jsonencode({
    "Version" = "2012-10-17",
    "Statement" = {
      "Sid"    = "AllowCloudFrontServicePrincipalReadOnly",
      "Effect" = "Allow",
      "Principal" = {
        "Service" = "cloudfront.amazonaws.com"
      },
      "Action"   = "s3:GetObject",
      "Resource" = "arn:aws:s3:::${aws_s3_bucket.teratown_bucket.id}/*",
      "Condition" = {
        "StringEquals" = {
          #"AWS:SourceArn": data.aws_caller_identity.current.arn
          "AWS:SourceArn" = "arn:aws:cloudfront::${data.aws_caller_identity.current.account_id}:distribution/${aws_cloudfront_distribution.s3_distribution.id}"
        }
      }
    }
  })
}

# create a sample resource that we can use to manage the state of a version number
resource "terraform_data" "content_version" {
  input = var.content_version
}

