# Resume Website Infrastructure

This repository contains Terraform infrastructure code to deploy a static resume website using AWS S3 and CloudFront.

## Architecture

```
Internet → CloudFront (CDN) → S3 Bucket (Private)
```

### Components

- **S3 Bucket**: Hosts static website files (private, accessed only via CloudFront)
- **CloudFront Distribution**: Provides global CDN with HTTPS termination
- **Origin Access Control (OAC)**: Secures S3 bucket access to CloudFront only

## Prerequisites

1. **AWS Account** with appropriate permissions
2. **Terraform** installed (>= 1.6)
3. **AWS CLI** configured with your credentials
4. **Website files** ready in the `website/` directory

## Quick Start

### 1. Clone and Setup

```bash
git clone <your-repo-url>
cd resume-website-terraform/terraform
```

### 2. Configure Variables

```bash
# Copy the example variables file
cp terraform.tfvars.example terraform.tfvars

# Edit terraform.tfvars with your settings
nano terraform.tfvars
```

### 3. Setup Backend (Choose Option A or B)

**Option A: Local State (Simpler for learning)**
Comment out the backend configuration in `backend.tf`:

```hcl
# terraform {
#   backend "s3" {
#     ...
#   }
# }
```

**Option B: Remote State (Recommended for production)**
1. Create an S3 bucket for state storage
2. Update `backend.tf` with your bucket name
3. Run `terraform init`

### 4. Deploy Infrastructure

```bash
# Initialize Terraform
terraform init

# Review the deployment plan
terraform plan

# Apply the changes
terraform apply
```

### 5. Upload Website Files

After deployment, upload your website files to the S3 bucket:

```bash
# Get the bucket name from Terraform output
BUCKET_NAME=$(terraform output -raw s3_bucket_name)

# Upload your website files
aws s3 sync ../website/ s3://$BUCKET_NAME/ --delete

# Get your website URL
terraform output website_url
```

## File Structure

```
resume-website-terraform/
├── .github/workflows/          # GitHub Actions (coming next)
├── terraform/
│   ├── backend.tf             # S3 backend configuration
│   ├── locals.tf              # Local values and common tags
│   ├── main.tf                # Main infrastructure resources
│   ├── outputs.tf             # Output values
│   ├── terraform.tfvars.example # Example variables
│   ├── variables.tf           # Input variables
│   └── versions.tf            # Provider version constraints
├── website/                   # Your resume website files
│   ├── index.html
│   ├── styles.css
│   └── assets/
└── README.md
```

## Customization

### Variables

Edit `terraform.tfvars` to customize:

- `aws_region`: AWS region for deployment
- `project_name`: Used in resource naming
- `environment`: Environment tag (dev/staging/prod)
- `common_tags`: Additional tags for all resources

### Advanced Configuration

- Modify `main.tf` to adjust CloudFront behaviors
- Update `variables.tf` to add new configuration options
- Edit `locals.tf` to change MIME types or other local values

## Outputs

After deployment, Terraform provides:

- `website_url`: Your live website URL (HTTPS)
- `s3_bucket_name`: Bucket name for file uploads
- `cloudfront_distribution_id`: For cache invalidation

## Security Features

- S3 bucket is private (no public access)
- CloudFront enforces HTTPS
- Origin Access Control secures S3 access
- Server-side encryption enabled
- Versioning enabled for recovery

## Troubleshooting

### Common Issues

1. **403 Forbidden**: Check that `index.html` exists in your S3 bucket
2. **CloudFront not updating**: CloudFront caches content; wait 15-20 minutes or invalidate cache
3. **Terraform init fails**: Check your AWS credentials and permissions

### Cache Invalidation

To force CloudFront to serve updated content:

```bash
DISTRIBUTION_ID=$(terraform output -raw cloudfront_distribution_id)
aws cloudfront create-invalidation --distribution-id $DISTRIBUTION_ID --paths "/*"
```

## Cost Optimization

- CloudFront has a free tier (1TB transfer/month)
- S3 costs are minimal for static websites
- Consider enabling CloudFront compression for better performance

## Cleanup

To destroy all resources:

```bash
terraform destroy
```

## Next Steps

- Set up GitHub Actions for automated deployments
- Add custom domain with Route53 (when available)
- Implement WAF protection for production use
- Add monitoring with CloudWatch

## Support

For issues or questions:
1. Check the troubleshooting section above
2. Review Terraform and AWS documentation
3. Open an issue in this repository