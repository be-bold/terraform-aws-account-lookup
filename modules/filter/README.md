# terraform-aws-account-lookup-filter

ℹ️ Use this module in combination with [be-bold/terraform-aws-account-lookup](https://github.com/be-bold/terraform-aws-account-lookup).

## What it does

This module lets you filter a given input of AWS accounts and optionally group the results by a tag on an AWS account.

## How to use

The easiest way is to use the `account_list` from [be-bold/terraform-aws-account-lookup](https://github.com/be-bold/terraform-aws-account-lookup) as input.

```hcl
module "lookup" {
  source  = "be-bold/account-lookup/aws"
  version = "#.#.#"
}

module "filter" {
  source  = "be-bold/account-lookup/aws//modules/filter"
  version = "#.#.#"
  input   = module.lookup.account_list
}
```

### Filtering

There are two different filters that you can set: `include` and `exclude`.
The `include` filter will pick entries from the `input` that match and passes this subset to the `exclude` filter.
The `exclude` filter removes matching entries to further narrow down the result.
If you configured `group_by_tag` then these remaining entries will be grouped and finally be available on the `search_result`. 

Both `include`and `exclude` filter as well as `group_by_tag` are **optional**. So you are free to use only one filter or
only group entries or configure any combination of these three options. 

![Processing order for filtering and grouping](https://raw.githubusercontent.com/be-bold/terraform-aws-account-lookup/main/docs/filtering.png)

For each filter you set one or many properties. Each property is being explained in detail down below. If you set
multiple properties then these will be chained together using **AND**. Each property can take a set of values. The set
of values is chained together using **OR**.

![Chaining of properties and their values](https://raw.githubusercontent.com/be-bold/terraform-aws-account-lookup/main/docs/schema.png)

The structure for `include` and `exclude` is the same. The following examples show `include`, but the structure applies to both.

#### Id

Filter by one or many AWS account IDs. If you set multiple values then these will be chained together using **OR**.

```hcl
module "filter" {
  source  = "be-bold/account-lookup/aws//modules/filter"
  version = "#.#.#"
  input   = module.lookup.account_list

  include = {
    id = [
      "123456789012",
      "234567890123",
    ]
  }
}
```

#### ARN

Filter by the AWS accounts ARN. If you set multiple values then these will be chained together using **OR**.

```hcl
module "filter" {
  source  = "be-bold/account-lookup/aws//modules/filter"
  version = "#.#.#"
  input   = module.lookup.account_list

  include = {
    arn = [
      "arn:aws:organizations::000000000001:account/o-0abcd123ef/123456789012",
      "arn:aws:organizations::000000000001:account/o-0abcd123ef/234567890123",
    ]
  }
}
```

#### Name

Filter by the accounts name. This is not the alias that you set up in IAM, but the actual account name that you can also
see in the AWS SSO Login screen.
For `name` you have to pick one of the following matchers `startswith`, `endswith` or `equals`. You can choose only one
matcher which applies to all values. If you set multiple values then these will be chained together using **OR**.

```hcl
module "filter" {
  source  = "be-bold/account-lookup/aws//modules/filter"
  version = "#.#.#"
  input   = module.lookup.account_list

  include = {
    name = {
        matcher = "equals"
        values = [
          "account01",
          "account02",
        ]
    }
  }
}
```

#### Email

Filter by the AWS accounts root email. If you set multiple values then these will be chained together using **OR**.

```hcl
module "filter" {
  source  = "be-bold/account-lookup/aws//modules/filter"
  version = "#.#.#"
  input   = module.lookup.account_list

  include = {
    email = [
      "account01@example.org",
      "account02@example.org",
    ]
  }
}
```

#### Status

Filter by the AWS accounts status. If you set multiple values then these will be chained together using **OR**.

ℹ️ Here is a difference between `include` and `exclude`. While `exclude` doesn't provide a default value, the default 
value for `include` contains a set containing `ACTIVE` as value. That means that even if the `include` filter hasn't been
set, only accounts in status `ACTIVE` will be part of the resulting subset. If you need accounts of any status then
just set `include` with `status` for all possible values. These are: `ACTIVE`, `SUSPENDED` and `PENDING_CLOSURE`. 

```hcl
module "filter" {
  source  = "be-bold/account-lookup/aws//modules/filter"
  version = "#.#.#"
  input   = module.lookup.account_list

  include = {
    status = [
      "ACTIVE",
      "SUSPENDED",
    ]
  }
}
```

#### Tags

Filter by the AWS accounts tags. If you set multiple tags then these will be chained by **AND**. If you set multiple
values for each tag then these will be chained together using **OR**.

```hcl
module "filter" {
  source  = "be-bold/account-lookup/aws//modules/filter"
  version = "#.#.#"
  input   = module.lookup.account_list

  include = {
    tags = {
      type = [
        "nonprod",
        "prod",
      ]
      team = [
        "team4",
      ]
    }
  }
}
```

### Grouping

You can group the result set by any given tag.

```hcl
module "filter" {
  source  = "be-bold/account-lookup/aws//modules/filter"
  version = "#.#.#"
  input = [
    {
      id     = "123456789012"
      arn    = "arn:aws:organizations::000000000001:account/o-0abcd123ef/123456789012"
      name   = "account01"
      email  = "account01@example.org"
      status = "ACTIVE"
      tags   = {
        type = "sandbox"
        team = "team1"
      }
    },
    {
      id     = "234567890123"
      arn    = "arn:aws:organizations::000000000001:account/o-0abcd123ef/234567890123"
      name   = "account02"
      email  = "account02@example.org"
      status = "ACTIVE"
      tags   = {
        type = "nonprod"
        team = "team1"
      }
    },
    {
      id     = "345678901234"
      arn    = "arn:aws:organizations::000000000001:account/o-0abcd123ef/345678901234"
      name   = "account03"
      email  = "account03@example.org"
      status = "ACTIVE"
      tags   = {
        type = "prod"
        team = "team2"
      }
    },
    {
      id     = "456789012345"
      arn    = "arn:aws:organizations::000000000001:account/o-0abcd123ef/456789012345"
      name   = "account04"
      email  = "account04@example.org"
      status = "ACTIVE"
      tags   = {
        type = "prod"
        team = "team3"
      }
    },
  ]
  group_by_tag = "type"
}

output "result" {
  value = module.filter.search_result
}
```

Here is what the output would look like:

```text
Changes to Outputs:
  + result = {
      + nonprod = [
          + {
              + arn    = "arn:aws:organizations::000000000001:account/o-0abcd123ef/234567890123"
              + email  = "account02@example.org"
              + id     = "234567890123"
              + name   = "account02"
              + status = "ACTIVE"
              + tags   = {
                  + team = "team1"
                  + type = "nonprod"
                }
            },
        ]
      + prod    = [
          + {
              + arn    = "arn:aws:organizations::000000000001:account/o-0abcd123ef/345678901234"
              + email  = "account03@example.org"
              + id     = "345678901234"
              + name   = "account03"
              + status = "ACTIVE"
              + tags   = {
                  + team = "team2"
                  + type = "prod"
                }
            },
          + {
              + arn    = "arn:aws:organizations::000000000001:account/o-0abcd123ef/456789012345"
              + email  = "account04@example.org"
              + id     = "456789012345"
              + name   = "account04"
              + status = "ACTIVE"
              + tags   = {
                  + team = "team3"
                  + type = "prod"
                }
            },
        ]
      + sandbox = [
          + {
              + arn    = "arn:aws:organizations::000000000001:account/o-0abcd123ef/123456789012"
              + email  = "account01@example.org"
              + id     = "123456789012"
              + name   = "account01"
              + status = "ACTIVE"
              + tags   = {
                  + team = "team1"
                  + type = "sandbox"
                }
            },
        ]
    }
```

#### Not setting group_by_tag

If you don't set `group_by_tag` then there will be an entry for each account with the account ID as key:

```text
Changes to Outputs:
  + result = {
      + "123456789012" = [
          + {
              + arn    = "arn:aws:organizations::000000000001:account/o-0abcd123ef/123456789012"
              + email  = "account01@example.org"
              + id     = "123456789012"
              + name   = "account01"
              + status = "ACTIVE"
              + tags   = {
                  + type = "sandbox"
                }
            },
        ]
      + "234567890123" = [
          + {
              + arn    = "arn:aws:organizations::000000000001:account/o-0abcd123ef/234567890123"
              + email  = "account02@example.org"
              + id     = "234567890123"
              + name   = "account02"
              + status = "ACTIVE"
              + tags   = {
                  + type = "nonprod"
                }
            },
        ]
      + "345678901234" = [
          + {
              + arn    = "arn:aws:organizations::000000000001:account/o-0abcd123ef/345678901234"
              + email  = "account03@example.org"
              + id     = "345678901234"
              + name   = "account03"
              + status = "ACTIVE"
              + tags   = {
                  + type = "prod"
                }
            },
        ]
      + "456789012345" = [
          + {
              + arn    = "arn:aws:organizations::000000000001:account/o-0abcd123ef/456789012345"
              + email  = "account04@example.org"
              + id     = "456789012345"
              + name   = "account04"
              + status = "ACTIVE"
              + tags   = {
                  + type = "prod"
                }
            },
        ]
    }
```

#### Tags not provided by every account

If you want to group by a tag that is not provided by every account, then the result set will contain an additional
entry. The key is `group_id_missing`. This entry contains all accounts which didn't provide the tag.

The module provides an output for retrieving the name of that entry dynamically. So in case it changes you don't have to
adjust your code. You can retrieve that name using `search_result_group_id_missing_key`.

```hcl
module "filter" {
  source  = "be-bold/account-lookup/aws//modules/filter"
  version = "#.#.#"
  input = [
    {
      id     = "123456789012"
      arn    = "arn:aws:organizations::000000000001:account/o-0abcd123ef/123456789012"
      name   = "account01"
      email  = "account01@example.org"
      status = "ACTIVE"
      tags   = {
        team = "team1"
      }
    },
    {
      id     = "234567890123"
      arn    = "arn:aws:organizations::000000000001:account/o-0abcd123ef/234567890123"
      name   = "account02"
      email  = "account02@example.org"
      status = "ACTIVE"
      tags   = {
        type = "nonprod"
        team = "team1"
      }
    },
    {
      id     = "345678901234"
      arn    = "arn:aws:organizations::000000000001:account/o-0abcd123ef/345678901234"
      name   = "account03"
      email  = "account03@example.org"
      status = "ACTIVE"
      tags   = {
        type = "prod"
        team = "team2"
      }
    },
    {
      id     = "456789012345"
      arn    = "arn:aws:organizations::000000000001:account/o-0abcd123ef/456789012345"
      name   = "account04"
      email  = "account04@example.org"
      status = "ACTIVE"
      tags   = {
        team = "team3"
      }
    },
  ]
  group_by_tag = "type"
}

output "result" {
  value = module.filter.search_result
}
```

And this is what the output looks like:

```text
Changes to Outputs:
  + result = {
      + group_id_missing = [
          + {
              + arn    = "arn:aws:organizations::000000000001:account/o-0abcd123ef/123456789012"
              + email  = "account01@example.org"
              + id     = "123456789012"
              + name   = "account01"
              + status = "ACTIVE"
              + tags   = {
                  + team = "team1"
                }
            },
          + {
              + arn    = "arn:aws:organizations::000000000001:account/o-0abcd123ef/456789012345"
              + email  = "account04@example.org"
              + id     = "456789012345"
              + name   = "account04"
              + status = "ACTIVE"
              + tags   = {
                  + team = "team3"
                }
            },
        ]
      + nonprod          = [
          + {
              + arn    = "arn:aws:organizations::000000000001:account/o-0abcd123ef/234567890123"
              + email  = "account02@example.org"
              + id     = "234567890123"
              + name   = "account02"
              + status = "ACTIVE"
              + tags   = {
                  + team = "team1"
                  + type = "nonprod"
                }
            },
        ]
      + prod             = [
          + {
              + arn    = "arn:aws:organizations::000000000001:account/o-0abcd123ef/345678901234"
              + email  = "account03@example.org"
              + id     = "345678901234"
              + name   = "account03"
              + status = "ACTIVE"
              + tags   = {
                  + team = "team2"
                  + type = "prod"
                }
            },
        ]
    }
```

Have a look at the **examples** as well.