terraform {
  backend "s3" {
    bucket  = "emmanuel-tf-state-2025"
    key     = "resume-website/terraform.tfstate"
    region  = "us-east-2"
    encrypt = true
  }
}

