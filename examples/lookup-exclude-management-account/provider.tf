terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "#.#.#"
    }
  }
}

provider "aws" {
  region = "####"
  alias  = "organization_read_role"

  assume_role {
    role_arn = "arn:aws:iam::############:role/organization-read-role"
  }
}