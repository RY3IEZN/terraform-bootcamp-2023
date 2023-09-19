# create random string
resource "random_string" "bucket_name" {
  length  = 16
  upper   = false
  special = false
}


# create the terauckets
resource "aws_s3_bucket" "towntera_buckets" {
  bucket = random_string.bucket_name.result
}

# create output to see name
output "randomly_gen_name" {
  value = random_string.bucket_name.id
}
