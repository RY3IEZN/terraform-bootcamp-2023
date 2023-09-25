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
  bucket = aws_s3_bucket.teratown_bucket.bucket
  key    = "index.html"
  source = "${path.root}/public/index.html"

  etag = filemd5("${path.root}/public/index.html")
}

# create error.html object inside bucket
resource "aws_s3_object" "error_html_object" {
  bucket = aws_s3_bucket.teratown_bucket.bucket
  key    = "error.html"
  source = "${path.root}/public/error.html"

  etag = filemd5("${path.root}/public/error.html")
}
