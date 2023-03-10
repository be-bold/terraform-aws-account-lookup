# terraform-aws-account-lookup

This module allows you to list AWS accounts of an organization in various forms.
* List accounts ids (with or without root account)
* Get mapping of **account id => account name** and vice versa (with or without root account)
* Get mapping **account id => account tags** (with or without root account)
* Get mapping **account name => account tags** (with or without root account)
* Group accounts by property (with or without root account)

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
                "organizations:ListAWSServiceAccessForOrganization",
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
  version = "1.0.0"
  providers = {
    aws.org_root_account = aws.org_root_account
  }
}
```