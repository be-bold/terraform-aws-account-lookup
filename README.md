# terraform-aws-account-lookup

This module allows you to list AWS accounts of an organization in various forms.
* List accounts ids (with or without management account)
* Get mapping of **account id => account name** and vice versa (with or without management account)
* Get mapping **account id => account tags** (with or without management account)
* Get mapping **account name => account tags** (with or without management account)
* Query accounts and retrieve all data including account tags
  * Include or exclude management account
  * Group accounts by tags
  * Set include filter
  * Set exclude filter

## Prerequisites

You need a role in your organization management account which allows the following:

```json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "organizations:DescribeOrganization",
                "organizations:ListAccounts",
                "organizations:ListRoots",
                "organizations:ListAccountsForParent",
                "organizations:ListParents",
                "organizations:ListTagsForResource",
                "organizations:ListOrganizationalUnitsForParent"
            ],
            "Resource": [
                "*"
            ]
        }
    ]
}
```

Create a provider which references this role:

```hcl
provider "aws" {
  region = "YOUR-REGION-HERE"
  alias  = "org_management_account"

  assume_role {
    role_arn = "arn:aws:iam::############:role/organization-read-role"
  }
}
```

Call the module using this provider:

```hcl
module "test" {
  source    = "be-bold/account-lookup/aws"
  version   = "#.#.#"
  providers = {
    aws.org_management_account = aws.org_management_account
  }
}
```

Use one of the static outputs:

````hcl
output "show" {
  value = module.test.all_accounts_tags_by_account_name
}
````

Or set input parameters to search for a specific set of accounts using `search_result`:
You can use multiple values which are connected using `or`.

```hcl
module "test" {
  source    = "be-bold/account-lookup/aws"
  version   = "#.#.#"
  providers = {
    aws.org_management_account = aws.org_management_account
  }
  
  include_management_account = false
  include = {
    tags  = {
      type = ["development"]
      team = ["my-team"]
    }
  }
  exclude = {
    name  = {
      matcher = "startswith"
      values  = ["test-"]
    }
  }
  group_by = "project"
}

output "show" {
  value = module.test.search_result
}
```

Except for `search_result` all outputs are static. All input parameters of this module only affect `search_result`.
Set multiple input parameters to further narrow down your results.
