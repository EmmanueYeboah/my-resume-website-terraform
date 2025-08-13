# Terraform Backend Configuration
# Commented out for initial deployment - uncomment after first successful run

# terraform {
#   backend "s3" {
#     bucket  = "your-terraform-state-bucket-name"
#     key     = "resume-website/terraform.tfstate" 
#     region  = "us-east-2"
#     encrypt = true
#   }
# }

# Note: Comment this back in after your first successful deployment
# and create an S3 bucket for state storage
