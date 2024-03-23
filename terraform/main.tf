

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.40.0"
    }
  }

  required_version = ">= 1.5.0"

  backend "s3" {
    bucket         = "terraform-state-bucket-5c8434af-209b-4761-8d60-2d40a4f83ea9"
    key            = "state/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "terraform-state-lock"
  }
}

provider "aws" {
  region = "us-east-1"
}