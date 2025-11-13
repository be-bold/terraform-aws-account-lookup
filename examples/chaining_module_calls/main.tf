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