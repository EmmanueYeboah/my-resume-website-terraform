variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-2"
}

variable "project_name" {
  description = "Project name"
  type        = string
  default     = "resume-website"
}

variable "environment" {
  description = "Environment"
  type        = string
  default     = "dev"
}

# Add your variable declarations below

variable "common_tags" {
  description = "A map of common tags to apply to resources"
  type        = map(string)
  default     = {}
}
# Updated Wed Aug 13 20:55:33 GMT 2025
