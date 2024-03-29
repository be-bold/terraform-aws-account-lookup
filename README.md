# terraform-aws-account-lookup

ℹ️ Use this module in combination with the [filter submodule](https://github.com/be-bold/terraform-aws-account-lookup/tree/main/modules/filter) to further narrow down the list of accounts and be able to group them using tags.

## What it does

This module allows you to list AWS accounts of an organization in various forms. Once initialized you can retrieve the following data:
* Organization id
* Account id of your organizations management account
* Name of your organizations management account
* Mapping `id` _to_ `name`
* Mapping `name` _to_ `id`
* Mapping `id` _to_ `tags`
* Mapping `name` _to_ `tags`
* A list of all accounts with all of their properties present (`id`, `arn`, `name`, `email`, `status`, `tags`)

## How to use

The role with which you are running terraform on this module requires the following permissions:

```text
"organizations:ListRoots",
"organizations:ListTagsForResource",
"organizations:ListAccounts",
"organizations:DescribeOrganization",
"organizations:ListAWSServiceAccessForOrganization"
```

Either the role on your default provider allows these actions already or you want to add them to that role.
Alternatively you can create a distinct role for this case. We'll have a look at both cases down below.

### Using default provider

Call the module using this provider and decide whether to include the management account in the output lists or not (default is `true`):

```hcl
module "lookup" {
  source    = "be-bold/account-lookup/aws"
  version   = "#.#.#"
  include_management_account = false
}
```

**Done**. Now call one of the multiple output options:

````hcl
output "show" {
  value = module.lookup.mapping_id_to_name
}
````

### Custom role

You need a role which allows the following actions:

```json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
              "organizations:ListRoots",
              "organizations:ListTagsForResource",
              "organizations:ListAccounts",
              "organizations:DescribeOrganization",
              "organizations:ListAWSServiceAccessForOrganization"
            ],
            "Resource": "*"
        }
    ]
}
```

Create a provider which references this role:

```hcl
provider "aws" {
  region = "YOUR-REGION-HERE"
  alias  = "organization_read_role"

  assume_role {
    role_arn = "arn:aws:iam::############:role/organization-read-role"
  }
}
```

**Done**. Now call the module using this provider and decide whether to include the management account in the output lists or not (default is `true`):

```hcl
module "lookup" {
  source    = "be-bold/account-lookup/aws"
  version   = "#.#.#"
  providers = {
    aws = aws.organization_read_role
  }
  include_management_account = false
}
```

Call one of the multiple output options:

````hcl
output "show" {
  value = module.lookup.mapping_id_to_name
}
````

## Further filtering

Use the [filter submodule](https://github.com/be-bold/terraform-aws-account-lookup/tree/main/modules/filter) for even more control on your lists.
Have a look at the **examples** as well.