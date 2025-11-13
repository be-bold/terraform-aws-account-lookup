# terraform-aws-account-lookup-filter

> [!TIP]
> Use this module in combination with [be-bold/terraform-aws-account-lookup](https://github.com/be-bold/terraform-aws-account-lookup)  by passing its `account_list` as the input to this module.

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
The `exclude` filter removes matching entries to further narrow down the result. You can change the order by chaining
module calls (see section **chaining module calls**).
If you configured `group_by_tag` then these remaining entries will be grouped and finally be available on the `result`. 

Both `include`and `exclude` filter as well as `group_by_tag` are **optional**. So you are free to use only one filter or
only group entries or configure any combination of these three options. 

![Processing order for filtering and grouping](https://raw.githubusercontent.com/be-bold/terraform-aws-account-lookup/main/modules/filter/docs/filtering.png)

For each filter you set one or many properties. Each property is being explained in detail down below. If you set
multiple properties then these will be chained together using **AND**. Each property can take a set of values. The set
of values is chained together using **OR**.

![Chaining of properties and their values](https://raw.githubusercontent.com/be-bold/terraform-aws-account-lookup/main/modules/filter/docs/schema.png)

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

#### State

Filter by the AWS accounts state. If you set multiple values then these will be chained together using **OR**.

ℹ️ Here is a difference between `include` and `exclude`. While `exclude` doesn't provide a default value, the default
value for `include` contains a set containing `ACTIVE` as value. That means that even if the `include` filter hasn't been
set, only accounts in state `ACTIVE` will be part of the resulting subset. If you need accounts of any state then
just set `include` with `state` for all possible values. These are:
`["PENDING_ACTIVATION", "ACTIVE", "SUSPENDED", "PENDING_CLOSURE", "CLOSED"]`

```hcl
module "filter" {
  source  = "be-bold/account-lookup/aws//modules/filter"
  version = "#.#.#"

  input   = module.lookup.account_list

  include = {
    state = [
      "ACTIVE",
      "PENDING_CLOSURE",
    ]
  }
}
```

#### Name

Filter by the accounts name. This is not the alias that you set up in IAM, but the actual account name that you can also
see in the AWS SSO Login screen.
For `name` you have to pick one of the following matchers `startswith`, `endswith`, `equals`, `contains` or `regex`. You can choose only one
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

#### Joined Method

Filter by the method with which the AWS accounts joined the organization. Valid values are either `CREATED` or `INVITED`.
If you set multiple values then these will be chained together using **OR**.

```hcl
module "filter" {
  source  = "be-bold/account-lookup/aws//modules/filter"
  version = "#.#.#"

  input   = module.lookup.account_list

  include = {
    joined = {
      method = [
        "INVITED",
      ]
    }
  }
}
```

#### Joined Timestamp

Filter by the timestamp at which the AWS accounts joined the organization. For `is` you have to pick one of the following matchers:
`before`, `equals`, `after`. You cannot set multiple values for `other_timestamp`.

```hcl
module "filter" {
  source  = "be-bold/account-lookup/aws//modules/filter"
  version = "#.#.#"

  input   = module.lookup.account_list

  include = {
    joined = {
      timestamp = {
        is = "before"
        other_timestamp = "2025-01-01T00:00:00.000000+01:00"
      }
    }
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

You can group the result by any given tag.

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
      state  = "ACTIVE"
      tags   = {
        type = "sandbox"
        team = "team1"
      }
      joined = {
        method    = "CREATED"
        timestamp = "2025-01-01T14:03:56.054000+01:00"
      }
    },
    {
      id     = "234567890123"
      arn    = "arn:aws:organizations::000000000001:account/o-0abcd123ef/234567890123"
      name   = "account02"
      email  = "account02@example.org"
      state  = "ACTIVE"
      tags   = {
        type = "nonprod"
        team = "team1"
      }
      joined = {
        method    = "CREATED"
        timestamp = "2025-01-02T14:03:56.054000+01:00"
      }
    },
    {
      id     = "345678901234"
      arn    = "arn:aws:organizations::000000000001:account/o-0abcd123ef/345678901234"
      name   = "account03"
      email  = "account03@example.org"
      state  = "ACTIVE"
      tags   = {
        type = "prod"
        team = "team2"
      }
      joined = {
        method    = "CREATED"
        timestamp = "2025-01-03T14:03:56.054000+01:00"
      }
    },
    {
      id     = "456789012345"
      arn    = "arn:aws:organizations::000000000001:account/o-0abcd123ef/456789012345"
      name   = "account04"
      email  = "account04@example.org"
      state  = "ACTIVE"
      tags   = {
        type = "prod"
        team = "team3"
      }
      joined = {
        method    = "CREATED"
        timestamp = "2025-01-04T14:03:56.054000+01:00"
      }
    },
  ]

  group_by_tag = "type"
}

output "result" {
  value = module.filter.result
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
              + state  = "ACTIVE"
              + tags   = {
                  + team = "team1"
                  + type = "nonprod"
                }
              + joined = {
                + method    = "CREATED"
                + timestamp = "2025-01-02T14:03:56.054000+01:00"
              }
            },
        ]
      + prod    = [
          + {
              + arn    = "arn:aws:organizations::000000000001:account/o-0abcd123ef/345678901234"
              + email  = "account03@example.org"
              + id     = "345678901234"
              + name   = "account03"
              + state  = "ACTIVE"
              + tags   = {
                  + team = "team2"
                  + type = "prod"
                }
              + joined = {
                + method    = "CREATED"
                + timestamp = "2025-01-03T14:03:56.054000+01:00"
              }
            },
          + {
              + arn    = "arn:aws:organizations::000000000001:account/o-0abcd123ef/456789012345"
              + email  = "account04@example.org"
              + id     = "456789012345"
              + name   = "account04"
              + state  = "ACTIVE"
              + tags   = {
                  + team = "team3"
                  + type = "prod"
                }
              + joined = {
                + method    = "CREATED"
                + timestamp = "2025-01-04T14:03:56.054000+01:00"
              }
            },
        ]
      + sandbox = [
          + {
              + arn    = "arn:aws:organizations::000000000001:account/o-0abcd123ef/123456789012"
              + email  = "account01@example.org"
              + id     = "123456789012"
              + name   = "account01"
              + state  = "ACTIVE"
              + tags   = {
                  + team = "team1"
                  + type = "sandbox"
                }
              + joined = {
                + method    = "CREATED"
                + timestamp = "2025-01-01T14:03:56.054000+01:00"
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
              + state  = "ACTIVE"
              + tags   = {
                  + type = "sandbox"
                }
              + joined = {
                + method    = "CREATED"
                + timestamp = "2025-01-01T14:03:56.054000+01:00"
              }
            },
        ]
      + "234567890123" = [
          + {
              + arn    = "arn:aws:organizations::000000000001:account/o-0abcd123ef/234567890123"
              + email  = "account02@example.org"
              + id     = "234567890123"
              + name   = "account02"
              + state  = "ACTIVE"
              + tags   = {
                  + type = "nonprod"
                }
              + joined = {
                + method    = "CREATED"
                + timestamp = "2025-01-02T14:03:56.054000+01:00"
              }
            },
        ]
      + "345678901234" = [
          + {
              + arn    = "arn:aws:organizations::000000000001:account/o-0abcd123ef/345678901234"
              + email  = "account03@example.org"
              + id     = "345678901234"
              + name   = "account03"
              + state  = "ACTIVE"
              + tags   = {
                  + type = "prod"
                }
              + joined = {
                + method    = "CREATED"
                + timestamp = "2025-01-03T14:03:56.054000+01:00"
              }
            },
        ]
      + "456789012345" = [
          + {
              + arn    = "arn:aws:organizations::000000000001:account/o-0abcd123ef/456789012345"
              + email  = "account04@example.org"
              + id     = "456789012345"
              + name   = "account04"
              + state  = "ACTIVE"
              + tags   = {
                  + type = "prod"
                }
              + joined = {
                + method    = "CREATED"
                + timestamp = "2025-01-04T14:03:56.054000+01:00"
              }
            },
        ]
    }
```

#### Tags not provided by every account

If you want to group by a tag that is not provided by every account, then the result set will contain an additional
entry. The key is `group_id_missing`. This entry contains all accounts which didn't provide the tag.

The module provides an output for retrieving the name of that entry dynamically. So in case it changes you don't have to
adjust your code. You can retrieve that name using `result_group_id_missing_key`.

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
      state  = "ACTIVE"
      tags   = {
        team = "team1"
      }
      joined = {
        method    = "CREATED"
        timestamp = "2025-01-01T14:03:56.054000+01:00"
      }
    },
    {
      id     = "234567890123"
      arn    = "arn:aws:organizations::000000000001:account/o-0abcd123ef/234567890123"
      name   = "account02"
      email  = "account02@example.org"
      state  = "ACTIVE"
      tags   = {
        type = "nonprod"
        team = "team1"
      }
      joined = {
        method    = "CREATED"
        timestamp = "2025-01-02T14:03:56.054000+01:00"
      }
    },
    {
      id     = "345678901234"
      arn    = "arn:aws:organizations::000000000001:account/o-0abcd123ef/345678901234"
      name   = "account03"
      email  = "account03@example.org"
      state  = "ACTIVE"
      tags   = {
        type = "prod"
        team = "team2"
      }
      joined = {
        method    = "CREATED"
        timestamp = "2025-01-03T14:03:56.054000+01:00"
      }
    },
    {
      id     = "456789012345"
      arn    = "arn:aws:organizations::000000000001:account/o-0abcd123ef/456789012345"
      name   = "account04"
      email  = "account04@example.org"
      state  = "ACTIVE"
      tags   = {
        team = "team3"
      }
      joined = {
        method    = "CREATED"
        timestamp = "2025-01-04T14:03:56.054000+01:00"
      }
    },
  ]

  group_by_tag = "type"
}

output "result" {
  value = module.filter.result
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
              + state  = "ACTIVE"
              + tags   = {
                  + team = "team1"
                }
              + joined = {
                + method    = "CREATED"
                + timestamp = "2025-01-01T14:03:56.054000+01:00"
              }
            },
          + {
              + arn    = "arn:aws:organizations::000000000001:account/o-0abcd123ef/456789012345"
              + email  = "account04@example.org"
              + id     = "456789012345"
              + name   = "account04"
              + state  = "ACTIVE"
              + tags   = {
                  + team = "team3"
                }
              + joined = {
                + method    = "CREATED"
                + timestamp = "2025-01-04T14:03:56.054000+01:00"
              }
            },
        ]
      + nonprod          = [
          + {
              + arn    = "arn:aws:organizations::000000000001:account/o-0abcd123ef/234567890123"
              + email  = "account02@example.org"
              + id     = "234567890123"
              + name   = "account02"
              + state = "ACTIVE"
              + tags   = {
                  + team = "team1"
                  + type = "nonprod"
                }
              + joined = {
                + method    = "CREATED"
                + timestamp = "2025-01-02T14:03:56.054000+01:00"
              }
            },
        ]
      + prod             = [
          + {
              + arn    = "arn:aws:organizations::000000000001:account/o-0abcd123ef/345678901234"
              + email  = "account03@example.org"
              + id     = "345678901234"
              + name   = "account03"
              + state  = "ACTIVE"
              + tags   = {
                  + team = "team2"
                  + type = "prod"
                }
              + joined = {
                + method    = "CREATED"
                + timestamp = "2025-01-03T14:03:56.054000+01:00"
              }
            },
        ]
    }
```

Have a look at the **examples** as well.

### Chaining module calls

In the section **filtering** the order of execution is described. First `include` is applied on the list of accounts
followed by `exclude`. This module allows you to chain multiple module calls together. This way you could reverse the
execution order of `include` and `exclude` or apply multiple checks on `joined.timestamp` which only allows a single check.
All you have to do is wrap the `result` of the first module in `flatten()` and `values` like this:
`flatten(values(module.first_call.result))` and pass this as the input for the next module call.

You can find a full examples [here](../../examples/chaining_module_calls/README.md)