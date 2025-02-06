provider "aws" {
  region = var.region
  profile = var.aws_profile
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }

  # backend "s3" {  
  #   bucket       = "erik-terraform-states"  
  #   key          = "eks-deploy/statefile.tfstate"
  #   region       = "ap-east-1"
  #   encrypt      = true  
  #   use_lockfile = true  #S3 native locking
  # }  
}
