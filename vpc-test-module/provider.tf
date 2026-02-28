terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.33.0"
    }
  }

  backend "s3" {
    bucket = "eshurr"
    key    = "vpc-test-module"
    region = "us-east-1"
  }
}

provider "aws" {
  # Configuration options
}