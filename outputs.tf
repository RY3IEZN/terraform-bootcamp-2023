output "s3_teratown_url" {
  description = "s3 bucket teratown url"
  value       = module.terrahouse.s3_teratown_url
}

output "cloudfront_url" {
  description = "cloud front url"
  value       = module.terrahouse.cloudfront_url
}
