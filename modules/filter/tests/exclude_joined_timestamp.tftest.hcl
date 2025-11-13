run "filter_using__exclude_joined_timestamp_is__-_throws_exception_for_null" {
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
      joined = {
        timestamp = {
          is = null
          other_timestamp = "2025-01-03T14:03:56.054000+01:00"
        }
      }
    }
  }

  command = plan

  expect_failures = [
    var.exclude.joined.timestamp.is,
  ]
}

run "filter_using__exclude_joined_timestamp_is__-_throws_exception_for_invalid_value" {
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
      joined = {
        timestamp = {
          is = "INVALID"
          other_timestamp = "2025-01-03T14:03:56.054000+01:00"
        }
      }
    }
  }

  command = plan

  expect_failures = [
    var.exclude.joined.timestamp.is,
  ]
}

run "filter_using__exclude_joined_timestamp_is__-_throws_exception_for_valid_value_but_in_upper_case" {
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
      joined = {
        timestamp = {
          is = "BEFORE"
          other_timestamp = "2025-01-03T14:03:56.054000+01:00"
        }
      }
    }
  }

  command = plan

  expect_failures = [
    var.exclude.joined.timestamp.is,
  ]
}


run "filter_using__exclude_joined_timestamp_other_timestamp__-_throws_exception_for_null" {
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
      joined = {
        timestamp = {
          is = "before"
          other_timestamp = null
        }
      }
    }
  }

  command = plan

  expect_failures = [
    var.exclude.joined.timestamp.other_timestamp,
  ]
}

run "filter_using__exclude_joined_timestamp_other_timestamp__-_throws_exception_for_invalid_value" {
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
      joined = {
        timestamp = {
          is = "before"
          other_timestamp = "INVALID"
        }
      }
    }
  }

  command = plan

  expect_failures = [
    var.exclude.joined.timestamp.other_timestamp,
  ]
}


run "filter_using__exclude_joined_timestamp_is__-_before_-_successfully_filter_for_single_entry_with_assertions_on_all_properties" {
  variables {
    input = [
      {
        id     = "123456789012"
        arn    = "arn:aws:organizations::000000000001:account/o-0abcd123ef/123456789012"
        name   = "prefix1-account01"
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
        name   = "prefix2-account02"
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
        name   = "prefix3-account03"
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
      joined = {
        timestamp = {
          is = "before"
          other_timestamp = "2025-01-03T00:00:00.000000+01:00"
        }
      }
    }
  }

  command = plan

  assert {
    condition = jsonencode(output.result) == jsonencode({
      345678901234 = [
        {
          id     = "345678901234"
          arn    = "arn:aws:organizations::000000000001:account/o-0abcd123ef/345678901234"
          name   = "prefix3-account03"
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
    })
    error_message = "Account list doesn't contain the expected entries."
  }
}

run "filter_using__exclude_joined_timestamp_is__-_before_-_successfully_filter_for_multiple_entries" {
  variables {
    input = [
      {
        id     = "123456789012"
        arn    = "arn:aws:organizations::000000000001:account/o-0abcd123ef/123456789012"
        name   = "prefix1-account01"
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
        name   = "prefix2-account02"
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
        name   = "prefix3-account03"
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
      joined = {
        timestamp = {
          is = "before"
          other_timestamp = "2025-01-02T00:00:00.000000+01:00"
        }
      }
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

run "filter_using__exclude_joined_timestamp_is__-_before_-_exclude_only_matching_entries" {
  variables {
    input = [
      {
        id     = "123456789012"
        arn    = "arn:aws:organizations::000000000001:account/o-0abcd123ef/123456789012"
        name   = "prefix1-account01"
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
        name   = "prefix2-account02"
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
        name   = "prefix3-account03"
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
      joined = {
        timestamp = {
          is = "before"
          other_timestamp = "2025-01-01T00:00:00.000000+01:00"
        }
      }
    }
  }

  command = plan

  assert {
    condition = length(keys(local.result)) == 3
    error_message = "Expected 3 entries in search result."
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


run "filter_using__exclude_joined_timestamp_is__-_equals_-_successfully_filter_for_multiple_entries_with_assertions_on_all_properties" {
  variables {
    input = [
      {
        id     = "123456789012"
        arn    = "arn:aws:organizations::000000000001:account/o-0abcd123ef/123456789012"
        name   = "prefix1-account01"
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
        name   = "prefix2-account02"
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
        name   = "prefix3-account03"
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
      joined = {
        timestamp = {
          is = "equals"
          other_timestamp = "2025-01-02T14:03:56.054000+01:00"
        }
      }
    }
  }

  command = plan

  assert {
    condition = jsonencode(output.result) == jsonencode({
      123456789012 = [
        {
          id     = "123456789012"
          arn    = "arn:aws:organizations::000000000001:account/o-0abcd123ef/123456789012"
          name   = "prefix1-account01"
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
      ]
      345678901234 = [
        {
          id     = "345678901234"
          arn    = "arn:aws:organizations::000000000001:account/o-0abcd123ef/345678901234"
          name   = "prefix3-account03"
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
    })
    error_message = "Account list doesn't contain the expected entries."
  }
}

run "filter_using__exclude_joined_timestamp_is__-_equals_-_exclude_only_matching_entries_including_timestamp" {
  variables {
    input = [
      {
        id     = "123456789012"
        arn    = "arn:aws:organizations::000000000001:account/o-0abcd123ef/123456789012"
        name   = "prefix1-account01"
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
        name   = "prefix2-account02"
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
        name   = "prefix3-account03"
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
      joined = {
        timestamp = {
          is = "equals"
          other_timestamp = "2025-01-02T00:00:00.000000+01:00"
        }
      }
    }
  }

  command = plan

  assert {
    condition = length(keys(local.result)) == 3
    error_message = "Expected 3 entries in search result."
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


run "filter_using__exclude_joined_timestamp_is__-_after_-_successfully_filter_for_single_entry_with_assertions_on_all_properties" {
  variables {
    input = [
      {
        id     = "123456789012"
        arn    = "arn:aws:organizations::000000000001:account/o-0abcd123ef/123456789012"
        name   = "prefix1-account01"
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
        name   = "prefix2-account02"
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
        name   = "prefix3-account03"
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
      joined = {
        timestamp = {
          is = "after"
          other_timestamp = "2025-01-02T00:00:00.000000+01:00"
        }
      }
    }
  }

  command = plan

  assert {
    condition = jsonencode(output.result) == jsonencode({
      123456789012 = [
        {
          id     = "123456789012"
          arn    = "arn:aws:organizations::000000000001:account/o-0abcd123ef/123456789012"
          name   = "prefix1-account01"
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
      ]
    })
    error_message = "Account list doesn't contain the expected entries."
  }
}

run "filter_using__exclude_joined_timestamp_is__-_after_-_successfully_filter_for_multiple_entries" {
  variables {
    input = [
      {
        id     = "123456789012"
        arn    = "arn:aws:organizations::000000000001:account/o-0abcd123ef/123456789012"
        name   = "prefix1-account01"
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
        name   = "prefix2-account02"
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
        name   = "prefix3-account03"
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
      joined = {
        timestamp = {
          is = "after"
          other_timestamp = "2025-01-03T00:00:00.000000+01:00"
        }
      }
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
    condition = length(local.result["234567890123"]) == 1
    error_message = "Expected entry not found or contains more entries than expected."
  }
}

run "filter_using__exclude_joined_timestamp_is__-_after_-_exclude_only_matching_entries" {
  variables {
    input = [
      {
        id     = "123456789012"
        arn    = "arn:aws:organizations::000000000001:account/o-0abcd123ef/123456789012"
        name   = "prefix1-account01"
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
        name   = "prefix2-account02"
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
        name   = "prefix3-account03"
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
      joined = {
        timestamp = {
          is = "after"
          other_timestamp = "2025-01-04T00:00:00.000000+01:00"
        }
      }
    }
  }

  command = plan

  assert {
    condition = length(keys(local.result)) == 3
    error_message = "Expected 3 entries in search result."
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