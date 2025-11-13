run "filter_using__exclude_name_matcher__-_throws_exception_for_null" {
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
      name = {
        matcher = null
        values = [
          "account01",
        ]
      }
    }
  }

  command = plan

  expect_failures = [
    var.exclude.name.matcher,
  ]
}

run "filter_using__exclude_name_matcher__-_throws_exception_for_invalid_value" {
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
      name = {
        matcher = "unknown"
        values = [
          "account01",
        ]
      }
    }
  }

  command = plan

  expect_failures = [
    var.exclude.name.matcher,
  ]
}

run "filter_using__exclude_name_matcher__-_throws_exception_for_valid_value_but_in_lower_case" {
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
      name = {
        matcher = "STARTSWITH"
        values = [
          "account01",
        ]
      }
    }
  }

  command = plan

  expect_failures = [
    var.exclude.name.matcher,
  ]
}


run "filter_using__exclude_name_values__-_throws_exception_for_null" {
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
      name = {
        matcher = "startswith"
        values = null
      }
    }
  }

  command = plan

  expect_failures = [
    var.exclude.name.values,
  ]
}


run "filter_using__exclude_name__-_startswith_-_successfully_filter_for_single_entry_with_assertions_on_all_properties" {
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
      name = {
        matcher = "startswith"
        values = [
          "prefix1-",
          "prefix3-",
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
      ]
    })
    error_message = "Account list doesn't contain the expected entries."
  }
}

run "filter_using__exclude_name__-_startswith_-_successfully_filter_for_multiple_entries" {
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
      name = {
        matcher = "startswith"
        values = [
          "prefix2-",
        ]
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
    condition = length(local.result["345678901234"]) == 1
    error_message = "Expected entry not found or contains more entries than expected."
  }
}

run "filter_using__exclude_name__-_startswith_-_only_return_known_entry_if_you_filter_for_known_and_unknown_entry" {
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
      name = {
        matcher = "startswith"
        values = [
          "prefix2-",
          "prefix3-",
          "unknown-",
        ]
      }
    }
  }

  command = plan

  assert {
    condition = length(keys(local.result)) == 1
    error_message = "Expected 1 entry in search result."
  }

  assert {
    condition = length(local.result["123456789012"]) == 1
    error_message = "Expected entry not found or contains more entries than expected."
  }
}

run "filter_using__exclude_name__-_startswith_-_unknown_entry_doesnt_exclude_anything" {
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
      name = {
        matcher = "startswith"
        values = [
          "unknown-",
        ]
      }
    }
  }

  command = plan

  assert {
    condition = length(local.result) == 3
    error_message = "Expected to return the original list if nothing matches."
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

run "filter_using__exclude_name__-_startswith_-_empty_values_list_doesnt_exclude_anything" {
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
      name = {
        matcher = "startswith"
        values = []
      }
    }
  }

  command = plan

  assert {
    condition = length(local.result) == 3
    error_message = "Expected to return the original list if nothing matches."
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


run "filter_using__exclude_name__-_endswith_-_successfully_filter_for_single_entry_with_assertions_on_all_properties" {
  variables {
    input = [
      {
        id     = "123456789012"
        arn    = "arn:aws:organizations::000000000001:account/o-0abcd123ef/123456789012"
        name   = "account01-suffix1"
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
        name   = "account02-suffix2"
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
        name   = "account03-suffix3"
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
      name = {
        matcher = "endswith"
        values = [
          "-suffix1",
          "-suffix3",
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
          name   = "account02-suffix2"
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
      ]
    })
    error_message = "Account list doesn't contain the expected entries."
  }
}

run "filter_using__exclude_name__-_endswith_-_successfully_filter_for_multiple_entries" {
  variables {
    input = [
      {
        id     = "123456789012"
        arn    = "arn:aws:organizations::000000000001:account/o-0abcd123ef/123456789012"
        name   = "account01-suffix1"
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
        name   = "account02-suffix2"
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
        name   = "account03-suffix3"
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
      name = {
        matcher = "endswith"
        values = [
          "-suffix2",
        ]
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
    condition = length(local.result["345678901234"]) == 1
    error_message = "Expected entry not found or contains more entries than expected."
  }
}

run "filter_using__exclude_name__-_endswith_-_only_return_known_entry_if_you_filter_for_known_and_unknown_entry" {
  variables {
    input = [
      {
        id     = "123456789012"
        arn    = "arn:aws:organizations::000000000001:account/o-0abcd123ef/123456789012"
        name   = "account01-suffix1"
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
        name   = "account02-suffix2"
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
        name   = "account03-suffix3"
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
      name = {
        matcher = "endswith"
        values = [
          "-suffix2",
          "-suffix3",
          "-unknown",
        ]
      }
    }
  }

  command = plan

  assert {
    condition = length(keys(local.result)) == 1
    error_message = "Expected 1 entry in search result."
  }

  assert {
    condition = length(local.result["123456789012"]) == 1
    error_message = "Expected entry not found or contains more entries than expected."
  }
}

run "filter_using__exclude_name__-_endswith_-_unknown_entry_doesnt_exclude_anything" {
  variables {
    input = [
      {
        id     = "123456789012"
        arn    = "arn:aws:organizations::000000000001:account/o-0abcd123ef/123456789012"
        name   = "account01-suffix1"
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
        name   = "account02-suffix2"
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
        name   = "account03-suffix3"
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
      name = {
        matcher = "startswith"
        values = [
          "-unknown",
        ]
      }
    }
  }

  command = plan

  assert {
    condition = length(local.result) == 3
    error_message = "Expected to return the original list if nothing matches."
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

run "filter_using__exclude_name__-_endswith_-_empty_values_list_doesnt_exclude_anything" {
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
      name = {
        matcher = "endswith"
        values = []
      }
    }
  }

  command = plan

  assert {
    condition = length(local.result) == 3
    error_message = "Expected to return the original list if nothing matches."
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


run "filter_using__exclude_name__-_equals_-_successfully_filter_for_single_entry_with_assertions_on_all_properties" {
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
      name = {
        matcher = "equals"
        values = [
          "account01",
          "account03",
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
            state  = "ACTIVE"
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

run "filter_using__exclude_name__-_equals_-_successfully_filter_for_multiple_entries" {
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
      name = {
        matcher = "equals"
        values = [
          "account02",
        ]
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
    condition = length(local.result["345678901234"]) == 1
    error_message = "Expected entry not found or contains more entries than expected."
  }
}

run "filter_using__exclude_name__-_equals_-_only_return_known_entry_if_you_filter_for_known_and_unknown_entry" {
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
      name = {
        matcher = "equals"
        values = [
          "account02",
          "account03",
          "unknown",
        ]
      }
    }
  }

  command = plan

  assert {
    condition = length(keys(local.result)) == 1
    error_message = "Expected 1 entry in search result."
  }

  assert {
    condition = length(local.result["123456789012"]) == 1
    error_message = "Expected entry not found or contains more entries than expected."
  }
}

run "filter_using__exclude_name__-_equals_-_unknown_entry_doesnt_exclude_anything" {
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
      name = {
        matcher = "equals"
        values = [
          "unknown",
        ]
      }
    }
  }

  command = plan

  assert {
    condition = length(local.result) == 3
    error_message = "Expected to return the original list if nothing matches."
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

run "filter_using__exclude_name__-_equals_-_empty_values_list_doesnt_exclude_anything" {
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
      name = {
        matcher = "equals"
        values = []
      }
    }
  }

  command = plan

  assert {
    condition = length(local.result) == 3
    error_message = "Expected to return the original list if nothing matches."
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


run "filter_using__exclude_name__-_contains_-_successfully_filter_for_single_entry_with_assertions_on_all_properties" {
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
      name = {
        matcher = "contains"
        values = [
          "1-a",
          "3-a",
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
      ]
    })
    error_message = "Account list doesn't contain the expected entries."
  }
}

run "filter_using__exclude_name__-_contains_-_successfully_filter_for_multiple_entries" {
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
      name = {
        matcher = "contains"
        values = [
          "2-",
        ]
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
    condition = length(local.result["345678901234"]) == 1
    error_message = "Expected entry not found or contains more entries than expected."
  }
}

run "filter_using__exclude_name__-_contains_-_only_return_known_entry_if_you_filter_for_known_and_unknown_entry" {
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
      name = {
        matcher = "contains"
        values = [
          "2-a",
          "3-a",
          "unknown-",
        ]
      }
    }
  }

  command = plan

  assert {
    condition = length(keys(local.result)) == 1
    error_message = "Expected 1 entry in search result."
  }

  assert {
    condition = length(local.result["123456789012"]) == 1
    error_message = "Expected entry not found or contains more entries than expected."
  }
}

run "filter_using__exclude_name__-_contains_-_unknown_entry_doesnt_exclude_anything" {
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
      name = {
        matcher = "contains"
        values = [
          "unknown-",
        ]
      }
    }
  }

  command = plan

  assert {
    condition = length(local.result) == 3
    error_message = "Expected to return the original list if nothing matches."
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

run "filter_using__exclude_name__-_contains_-_empty_values_list_doesnt_exclude_anything" {
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
      name = {
        matcher = "contains"
        values = []
      }
    }
  }

  command = plan

  assert {
    condition = length(local.result) == 3
    error_message = "Expected to return the original list if nothing matches."
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


run "filter_using__exclude_name__-_regex_-_successfully_filter_for_single_entry_with_assertions_on_all_properties" {
  variables {
    input = [
      {
        id     = "123456789012"
        arn    = "arn:aws:organizations::000000000001:account/o-0abcd123ef/123456789012"
        name   = "prefix1-account01-foo-ABCD-bar-suffix"
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
        name   = "prefix2-account02-foo-4567-bar-suffix"
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
        name   = "prefix3-account03-foo-F7K1-bar-suffix"
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
      name = {
        matcher = "regex"
        values = [
          "[A-D]{4}",
          "([A-Z]\\d){2}",
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
          name   = "prefix2-account02-foo-4567-bar-suffix"
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
      ]
    })
    error_message = "Account list doesn't contain the expected entries."
  }
}

run "filter_using__exclude_name__-_regex_-_successfully_filter_for_multiple_entries" {
  variables {
    input = [
      {
        id     = "123456789012"
        arn    = "arn:aws:organizations::000000000001:account/o-0abcd123ef/123456789012"
        name   = "prefix1-account01-foo-ABCD-bar-suffix"
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
        name   = "prefix2-account02-foo-4567-bar-suffix"
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
        name   = "prefix3-account03-foo-F7K1-bar-suffix"
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
      name = {
        matcher = "regex"
        values = [
          "\\d{4}",
        ]
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
    condition = length(local.result["345678901234"]) == 1
    error_message = "Expected entry not found or contains more entries than expected."
  }
}

run "filter_using__exclude_name__-_regex_-_only_return_known_entry_if_you_filter_for_known_and_unknown_entry" {
  variables {
    input = [
      {
        id     = "123456789012"
        arn    = "arn:aws:organizations::000000000001:account/o-0abcd123ef/123456789012"
        name   = "prefix1-account01-foo-ABCD-bar-suffix"
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
        name   = "prefix2-account02-foo-4567-bar-suffix"
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
        name   = "prefix3-account03-foo-F7K1-bar-suffix"
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
      name = {
        matcher = "regex"
        values = [
          "[A-D]{4}",
          "\\d{4}",
          "unknown-",
        ]
      }
    }
  }

  command = plan

  assert {
    condition = length(keys(local.result)) == 1
    error_message = "Expected 1 entry in search result."
  }

  assert {
    condition = length(local.result["345678901234"]) == 1
    error_message = "Expected entry not found or contains more entries than expected."
  }
}

run "filter_using__exclude_name__-_regex_-_unknown_entry_doesnt_exclude_anything" {
  variables {
    input = [
      {
        id     = "123456789012"
        arn    = "arn:aws:organizations::000000000001:account/o-0abcd123ef/123456789012"
        name   = "prefix1-account01-foo-ABCD-bar-suffix"
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
        name   = "prefix2-account02-foo-4567-bar-suffix"
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
        name   = "prefix3-account03-foo-F7K1-bar-suffix"
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
      name = {
        matcher = "regex"
        values = [
          "unknown-",
        ]
      }
    }
  }

  command = plan

  assert {
    condition = length(local.result) == 3
    error_message = "Expected to return the original list if nothing matches."
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

run "filter_using__exclude_name__-_regex_-_empty_values_list_doesnt_exclude_anything" {
  variables {
    input = [
      {
        id     = "123456789012"
        arn    = "arn:aws:organizations::000000000001:account/o-0abcd123ef/123456789012"
        name   = "prefix1-account01-foo-ABCD-bar-suffix"
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
        name   = "prefix2-account02-foo-4567-bar-suffix"
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
        name   = "prefix3-account03-foo-F7K1-bar-suffix"
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
      name = {
        matcher = "regex"
        values = []
      }
    }
  }

  command = plan

  assert {
    condition = length(local.result) == 3
    error_message = "Expected to return the original list if nothing matches."
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