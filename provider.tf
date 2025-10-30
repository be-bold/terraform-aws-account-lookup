terraform {
  required_version = ">=1.6.0"

  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = ">= 6.18.0" # Requires "state", "joined_method" and "joined_timestamp" which were introduced in 6.18.0
    }
  }
}