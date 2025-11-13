run "filter_using__exclude_state__-_successfully_filter_for_single_entry_with_assertions_on_all_properties" {
  variables {
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
        state  = "SUSPENDED"
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
        state  = "CLOSED"
        tags   = {
          type = "prod"
        }
        joined = {
          method    = "CREATED"
          timestamp = "2025-01-03T14:03:56.054000+01:00"
        }
      },
    ]

    # override the default
    include = {
      state = [
        "PENDING_ACTIVATION",
        "ACTIVE",
        "SUSPENDED",
        "PENDING_CLOSURE",
        "CLOSED",
      ]
    }

    exclude = {
      state = [
        "ACTIVE",
        "CLOSED",
      ]
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
          state  = "SUSPENDED"
          tags   = {
            type = "nonprod"
          }
          joined = {
            method    = "CREATED"
            timestamp = "2025-01-02T14:03:56.054000+01:00"
          }
        },
      ]
    })
    error_message = "Account list doesn't contain the expected entries."
  }
}

run "filter_using__exclude_state__-_successfully_filter_for_multiple_entries" {
  variables {
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
        state  = "SUSPENDED"
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
        state  = "PENDING_CLOSURE"
        tags   = {
          type = "prod"
        }
        joined = {
          method    = "CREATED"
          timestamp = "2025-01-03T14:03:56.054000+01:00"
        }
      },
    ]

    # override the default
    include = {
      state = [
        "PENDING_ACTIVATION",
        "ACTIVE",
        "SUSPENDED",
        "PENDING_CLOSURE",
        "CLOSED",
      ]
    }

    exclude = {
      state = [
        "SUSPENDED",
      ]
    }
  }

  command = plan

  assert {
    condition = length(keys(local.result)) == 2
    error_message = "Expected 2 entries in search result."
  }

  assert {
    condition = length(local.result["123456789012"]) == 1
    error_message = "Expected entry not found or contains more entries than expected."
  }

  assert {
    condition = length(local.result["345678901234"]) == 1
    error_message = "Expected entry not found or contains more entries than expected."
  }
}

run "filter_using__exclude_state__-_only_return_known_entry_if_you_filter_for_known_and_unknown_entry" {
  variables {
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
        state  = "SUSPENDED"
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
        state  = "SUSPENDED"
        tags   = {
          type = "prod"
        }
        joined = {
          method    = "CREATED"
          timestamp = "2025-01-03T14:03:56.054000+01:00"
        }
      },
    ]

    # override the default
    include = {
      state = [
        "PENDING_ACTIVATION",
        "ACTIVE",
        "SUSPENDED",
        "PENDING_CLOSURE",
        "CLOSED",
      ]
    }

    exclude = {
      state = [
        "ACTIVE",
        "PENDING_CLOSURE",
      ]
    }
  }

  command = plan

  assert {
    condition = length(keys(local.result)) == 2
    error_message = "Expected 2 entries in search result."
  }

  assert {
    condition = length(local.result["234567890123"]) == 1
    error_message = "Expected entry not found or contains more entries than expected."
  }

  assert {
    condition = length(local.result["345678901234"]) == 1
    error_message = "Expected entry not found or contains more entries than expected."
  }
}

run "filter_using__exclude_state__-_unknown_entry_doesnt_exclude_anything" {
  variables {
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
        state  = "SUSPENDED"
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
        state  = "SUSPENDED"
        tags   = {
          type = "prod"
        }
        joined = {
          method    = "CREATED"
          timestamp = "2025-01-03T14:03:56.054000+01:00"
        }
      },
    ]

    # override the default
    include = {
      state = [
        "PENDING_ACTIVATION",
        "ACTIVE",
        "SUSPENDED",
        "PENDING_CLOSURE",
        "CLOSED",
      ]
    }

    exclude = {
      state = [
        "PENDING_CLOSURE",
      ]
    }
  }

  command = plan

  assert {
    condition = length(keys(local.result)) == 3
    error_message = "Expected 2 entries in search result."
  }

  assert {
    condition = length(local.result["123456789012"]) == 1
    error_message = "Expected entry not found or contains more entries than expected."
  }

  assert {
    condition = length(local.result["234567890123"]) == 1
    error_message = "Expected entry not found or contains more entries than expected."
  }

  assert {
    condition = length(local.result["345678901234"]) == 1
    error_message = "Expected entry not found or contains more entries than expected."
  }
}