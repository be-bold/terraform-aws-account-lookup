module "lookup" {
  source  = "be-bold/account-lookup/aws"
  version = "#.#.#"

  providers = {
    aws = aws.OrganizationReadRole
  }
}

module "grouping" {
  source  = "be-bold/account-lookup/aws//modules/filter"
  version = "#.#.#"

  input = module.lookup.account_list

  exclude = {
    tags = {
      type = [
        "tooling",
      ]
    }
  }

  group_by_tag = "team"
}