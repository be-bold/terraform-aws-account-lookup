module "lookup" {
  source  = "be-bold/account-lookup/aws"
  version = "#.#.#"

  providers = {
    aws = aws.OrganizationReadRole
  }

  include_management_account = false
}