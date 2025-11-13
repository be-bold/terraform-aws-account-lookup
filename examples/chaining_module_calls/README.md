# Example: 'chaining module calls'

As described in the section [chaining module calls](../../modules/filter/README.md), you can pass the result of a filter
module output as the input to another filter module.

This example uses a static list as the primary source instead of the output of the lookup module. Have a look at the
[filtering example](../filtering/README.md) to see both module types working together.

## Setup

Here is a complete example passing the result of the first module as input to the second module.

```hcl
module "exclude" {
  source = "../modules/filter"

  input = [
    {
      id     = "123456789012"
      arn    = "arn:aws:organizations::000000000001:account/o-0abcd123ef/123456789012"
      name   = "account01"
      email  = "account01@example.org"
      state  = "ACTIVE"
      tags   = {
        type = "sandbox"
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
      }
      joined = {
        method    = "CREATED"
        timestamp = "2025-01-03T14:03:56.054000+01:00"
      }
    },
  ]

  exclude = {
    email = [
      "account03@example.org",
    ]
  }
}

module "include" {
  source = "../modules/filter"

  input = flatten(values(module.exclude.result))

  include = {
    joined = {
      timestamp = {
        is = "after"
        other_timestamp = "2025-01-02T00:00:00.000000+01:00"
      }
    }
  }
}
```

**Outputs:**

```hcl
output "result" {
  value = module.include.result
}
```


## Outputs

Here is an example of what the output would look like:

### Result

```text
Changes to Outputs:
  + result = {
      + "234567890123" = [
          + {
              + arn    = "arn:aws:organizations::000000000001:account/o-0abcd123ef/234567890123"
              + email  = "account02@example.org"
              + id     = "234567890123"
              + joined = {
                  + method    = "CREATED"
                  + timestamp = "2025-01-02T14:03:56.054000+01:00"
                }
              + name   = "account02"
              + state  = "ACTIVE"
              + tags   = {
                  + type = "nonprod"
                }
            },
        ]
    }
```