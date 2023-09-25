# create output to see name
output "randomly_gen_name" {
  value = random_string.bucket_name.id
}

output "s3_teratown_url" {
  description = "s3 teratown url"
  value       = aws_s3_bucket_website_configuration.teratown_website_config.website_endpoint
}

output "cloudfront_url" {
  description = "cloudfront url"
  value       = aws_cloudfront_distribution.s3_distribution.domain_name
}
