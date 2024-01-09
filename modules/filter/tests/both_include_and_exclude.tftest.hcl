run "filter_using_both_include_and_exclude_-_first_input_is_run_through_include_and_the_resulting_subset_is_checked_for_excludes" {
  variables {
    input = [
      {
        id     = "123456789012"
        arn    = "arn:aws:organizations::000000000001:account/o-0abcd123ef/123456789012"
        name   = "account01"
        email  = "account01@example.org"
        status = "ACTIVE"
        tags   = {
          type = "sandbox"
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
        }
      },
      {
        id     = "456789012345"
        arn    = "arn:aws:organizations::000000000001:account/o-0abcd123ef/456789012345"
        name   = "account04"
        email  = "account04@example.org"
        status = "ACTIVE"
        tags   = {
          type = "nonprod"
        }
      },
      {
        id     = "567890123456"
        arn    = "arn:aws:organizations::000000000001:account/o-0abcd123ef/567890123456"
        name   = "account05"
        email  = "account05@example.org"
        status = "ACTIVE"
        tags   = {
          type = "prod"
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
    condition = length(keys(local.search_result)) == 2
    error_message = "Expected 2 entries in search result."
  }

  assert {
    condition = length(local.search_result["234567890123"]) == 1
    error_message = "Expected entry not found or contains more entries than expected."
  }

  assert {
    condition = length(local.search_result["456789012345"]) == 1
    error_message = "Expected entry not found or contains more entries than expected."
  }
}