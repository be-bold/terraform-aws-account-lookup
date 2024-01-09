module "lookup" {
  source  = "be-bold/account-lookup/aws"
  version = "#.#.#"
  providers = {
    aws = aws.organization_read_role
  }
}

module "filter" {
  source  = "be-bold/account-lookup/aws//modules/filter"
  version = "#.#.#"
  input = module.lookup.account_list

  include = {
    tags = {
      type = [
        "nonprod",
        "prod",
      ]
    }
  }

  exclude = {
    name = {
      matcher = "endswith"
      values = [
        "y",
        "d",
      ]
    }
  }
}