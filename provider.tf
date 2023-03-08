terraform {
  required_providers {
    aws = {
      source                = "hashicorp/aws"
      configuration_aliases = [
        aws.org_root_account,
      ]
    }
  }
}