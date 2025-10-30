# Example: 'filtering'

This example will retrieve the list of accounts using the lookup module and passes them to the filter
module where several filter steps are being performed.

First we include only those accounts which have the `tag` named `type` set with either `nonprod` or `prod` as values.
From this subset we exclude all accounts whose name end with `y` or `d`.

## Setup

**Providers:**

```hcl
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "#.#.#"
    }
  }
}

provider "aws" {
  region = "####"
  alias  = "OrganizationReadRole"

  assume_role {
    role_arn = "arn:aws:iam::############:role/OrganizationReadRole"
  }
}
```

**Calling the modules:**

```hcl
module "lookup" {
  source  = "be-bold/account-lookup/aws"
  version = "#.#.#"

  providers = {
    aws = aws.OrganizationReadRole
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
```

**Outputs:**

```hcl
output "result" {
  value = module.filter.result
}
```


## Outputs

By default the result set is grouped by the account id.

Here is an example of what the output would look like:

### Result

```text
Changes to Outputs:
  + account_list = {
      + "123456789012" = [
          + {
              + arn    = "arn:aws:organizations::010101010101:account/o-0abcd123ef/123456789012"
              + email  = "team1@example.org"
              + id     = "123456789012"
              + name   = "security"
              + status = "ACTIVE"
              + state  = "ACTIVE"
              + tags   = {
                  + team = "team1"
                  + type = "prod"
                }
              + joined = {
                  + method    = "CREATED"
                  + timestamp = "2025-01-01T14:03:56.054000+01:00"
                }
            },
        ]
      + "345678901234" = [
          + {
              + arn    = "arn:aws:organizations::010101010101:account/o-0abcd123ef/345678901234"
              + email  = "team2@example.org"
              + id     = "345678901234"
              + name   = "workload"
              + status = "ACTIVE"
              + state  = "ACTIVE"
              + tags   = {
                  + team = "team2"
                  + type = "nonprod"
                }
              + joined = {
                  + method    = "CREATED"
                  + timestamp = "2025-01-03T14:03:56.054000+01:00"
                }
            },
        ]
    }
```