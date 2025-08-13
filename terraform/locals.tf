# Local values for reuse throughout the configuration
locals {
  # Common tags applied to all resources
  common_tags = merge(var.common_tags, {
    Environment = var.environment
    Project     = var.project_name
    CreatedBy   = "Terraform"
    CreatedAt   = timestamp()
  })

  # Bucket naming
  bucket_name = "${var.project_name}-website-${random_string.bucket_suffix.result}"
  
  # CloudFront settings
  cloudfront_comment = "${var.project_name} Resume Website - ${var.environment}"
  
  # MIME types for common web files
  mime_types = {
    ".html" = "text/html"
    ".css"  = "text/css"
    ".js"   = "text/javascript"
    ".json" = "application/json"
    ".png"  = "image/png"
    ".jpg"  = "image/jpeg"
    ".jpeg" = "image/jpeg"
    ".gif"  = "image/gif"
    ".svg"  = "image/svg+xml"
    ".ico"  = "image/x-icon"
    ".pdf"  = "application/pdf"
  }
}