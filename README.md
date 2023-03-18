# terraform-aws-account-lookup

This module allows you to list AWS accounts of an organization in various forms.
* List accounts ids (with or without root account)
* Get mapping of **account id => account name** and vice versa (with or without root account)
* Get mapping **account id => account tags** (with or without root account)
* Get mapping **account name => account tags** (with or without root account)
* Query accounts and retrieve all data (account id, account name and tags)
  * Include or exclude management account
  * Group accounts by tags (with or without root account)
  * Set include filter
  * Set exclude filter

## Prerequisites

You need a role in your organization root account which allows the following:

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
  alias  = "org_root_account"

  assume_role {
    role_arn = "arn:aws:iam::############:role/organization-read-role"
  }
}
```

Call the module using this provider:

```hcl
module "test" {
  source  = "be-bold/terraform-aws-account-lookup"
  version = "#.#.#"
  providers = {
    aws.org_root_account = aws.org_root_account
  }
}
```

Use one of the outputs:

````hcl
output "show" {
  value = module.test.all_accounts_tags_by_account_name
}
````

Except for `search_result` all outputs are static. All input parameter of this module only have an effect on
`search_result`. Set multiple input parameters to further narrow down your results.