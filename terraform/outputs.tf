output "s3_bucket_name" {
  description = "Name of the S3 bucket"
  value       = aws_s3_bucket.website_bucket.id
}

output "website_url" {
  description = "Website URL"
  value       = "https://${aws_cloudfront_distribution.website_distribution.domain_name}"
}

output "cloudfront_distribution_id" {
  description = "CloudFront distribution ID"
  value       = aws_cloudfront_distribution.website_distribution.id
}