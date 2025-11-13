# Example: 'grouping'

This example will retrieve the list of accounts using the lookup module and passes them to the filter
module.

First we exclude any account having the tag `type` set with the value `tooling`. The resulting subset is grouped by
the tag `team`.

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
```

**Outputs:**

```hcl
output "result" {
  value = module.grouping.result
}
```

## Outputs

Here are two examples of what the output would look like.

### Result with all accounts having `team` tag in place

This output expects the tag `team` to bet set on all accounts.

```text
Changes to Outputs:
  + account_list = {
      + "team1" = [
          + {
              + arn    = "arn:aws:organizations::010101010101:account/o-0abcd123ef/123456789012"
              + email  = "team1@example.org"
              + id     = "123456789012"
              + name   = "security"
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
      + "team2" = [
          + {
              + arn    = "arn:aws:organizations::010101010101:account/o-0abcd123ef/234567890123"
              + email  = "team2@example.org"
              + id     = "234567890123"
              + name   = "sandbox"
              + state  = "ACTIVE"
              + tags   = {
                  + team = "team2"
                  + type = "sandbox"
                }
              + joined = {
                  + method    = "CREATED"
                  + timestamp = "2025-01-02T14:03:56.054000+01:00"
                }
            },
          + {
              + arn    = "arn:aws:organizations::010101010101:account/o-0abcd123ef/345678901234"
              + email  = "team2@example.org"
              + id     = "345678901234"
              + name   = "workload"
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

### Untagged accounts

Any account that doesn't have a tag named `team` set, will be listed under the key `group_id_missing`. 

That could look like this:

```text
Changes to Outputs:
  + account_list = {
      + "team1" = [
          + {
              + arn    = "arn:aws:organizations::010101010101:account/o-0abcd123ef/123456789012"
              + email  = "team1@example.org"
              + id     = "123456789012"
              + name   = "security"
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
      + "team2" = [
          + {
              + arn    = "arn:aws:organizations::010101010101:account/o-0abcd123ef/345678901234"
              + email  = "team2@example.org"
              + id     = "345678901234"
              + name   = "workload"
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
      + "group_id_missing" = [
          + {
              + arn    = "arn:aws:organizations::010101010101:account/o-0abcd123ef/234567890123"
              + email  = "team2@example.org"
              + id     = "234567890123"
              + name   = "sandbox"
              + state  = "ACTIVE"
              + tags   = {
                  + type = "sandbox"
                }
              + joined = {
                  + method    = "CREATED"
                  + timestamp = "2025-01-02T14:03:56.054000+01:00"
                }
            },
        ]
    }
```