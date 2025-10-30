run "filter_using_both_include_and_exclude_-_first_input_is_run_through_include_and_the_resulting_subset_is_checked_for_excludes" {
  variables {
    input = [
      {
        id     = "123456789012"
        arn    = "arn:aws:organizations::000000000001:account/o-0abcd123ef/123456789012"
        name   = "account01"
        email  = "account01@example.org"
        status = "ACTIVE"
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
        status = "ACTIVE"
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
        status = "ACTIVE"
        state  = "ACTIVE"
        tags   = {
          type = "prod"
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
        status = "ACTIVE"
        state  = "ACTIVE"
        tags   = {
          type = "nonprod"
        }
        joined = {
          method    = "CREATED"
          timestamp = "2025-01-04T14:03:56.054000+01:00"
        }
      },
      {
        id     = "567890123456"
        arn    = "arn:aws:organizations::000000000001:account/o-0abcd123ef/567890123456"
        name   = "account05"
        email  = "account05@example.org"
        status = "ACTIVE"
        state  = "ACTIVE"
        tags   = {
          type = "prod"
        }
        joined = {
          method    = "CREATED"
          timestamp = "2025-01-05T14:03:56.054000+01:00"
        }
      },
    ]

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
          "3",
          "5",
        ]
      }
    }
  }

  command = plan

  assert {
    condition = jsonencode(output.result) == jsonencode({
      234567890123 = [
        {
          id     = "234567890123"
          arn    = "arn:aws:organizations::000000000001:account/o-0abcd123ef/234567890123"
          name   = "account02"
          email  = "account02@example.org"
          status = "ACTIVE"
          state  = "ACTIVE"
          tags = {
            type = "nonprod"
          }
          joined = {
            method    = "CREATED"
            timestamp = "2025-01-02T14:03:56.054000+01:00"
          }
        },
      ]
      456789012345 = [
        {
          id     = "456789012345"
          arn    = "arn:aws:organizations::000000000001:account/o-0abcd123ef/456789012345"
          name   = "account04"
          email  = "account04@example.org"
          status = "ACTIVE"
          state  = "ACTIVE"
          tags = {
            type = "nonprod"
          }
          joined = {
            method    = "CREATED"
            timestamp = "2025-01-04T14:03:56.054000+01:00"
          }
        },
      ]
    })
    error_message = "Account list doesn't contain the expected entries."
  }
}