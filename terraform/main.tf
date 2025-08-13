module "vpc" {
  source  = "git::https://github.com/EmmanueYeboah/terraform-aws-modules.git//vpc?ref=v1.0.0"
  vpc_cidr = "10.0.0.0/16"
  az_count = 2
}



