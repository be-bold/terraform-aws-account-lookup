module "lookup" {
  source  = "be-bold/account-lookup/aws"
  version = "#.#.#"
  providers = {
    aws = aws.organization_read_role
  }
  include_management_account = false
}