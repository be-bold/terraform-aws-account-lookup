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
  alias  = "OrganizationReadRole"

  assume_role {
    role_arn = "arn:aws:iam::############:role/OrganizationReadRole"
  }
}