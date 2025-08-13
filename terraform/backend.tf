terraform {
  backend "s3" {
    bucket         = "emmanuel-tf-state-2025" # Your bucket
    key            = "terraform.tfstate"
    region         = "us-east-2"
    encrypt        = true
    bucket_locking = true
  }
}
