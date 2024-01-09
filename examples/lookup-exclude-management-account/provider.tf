terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.31.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
  alias  = "organization_read_role"

  assume_role {
    role_arn = "arn:aws:iam::############:role/organization-read-role"
  }
}