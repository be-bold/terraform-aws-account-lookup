run "filter_using___include_name_matcher___-_throws_exception_for_null" {
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
      },
      {
        id     = "345678901234"
        arn    = "arn:aws:organizations::000000000001:account/o-0abcd123ef/345678901234"
        name   = "account03"
        email  = "account03@example.org"
        status = "ACTIVE"
        state = "ACTIVE"
        tags   = {
          type = "prod"
        }
      },
    ]

    include = {
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
    var.include.name.matcher,
  ]
}

run "filter_using___include_name_matcher___-_throws_exception_for_invalid_value" {
  variables {
    input = [
      {
        id     = "123456789012"
        arn    = "arn:aws:organizations::000000000001:account/o-0abcd123ef/123456789012"
        name   = "account01"
        email  = "account01@example.org"
        status = "ACTIVE"
        state = "ACTIVE"
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
        state = "ACTIVE"
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
        state = "ACTIVE"
        tags   = {
          type = "prod"
        }
      },
    ]

    include = {
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
    var.include.name.matcher,
  ]
}

run "filter_using___include_name_matcher___-_throws_exception_for_valid_value_but_in_lower_case" {
  variables {
    input = [
      {
        id     = "123456789012"
        arn    = "arn:aws:organizations::000000000001:account/o-0abcd123ef/123456789012"
        name   = "account01"
        email  = "account01@example.org"
        status = "ACTIVE"
        state = "ACTIVE"
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
        state = "ACTIVE"
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
        state = "ACTIVE"
        tags   = {
          type = "prod"
        }
      },
    ]

    include = {
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
    var.include.name.matcher,
  ]
}


run "filter_using__include_name_values__-_throws_exception_for_null" {
  variables {
    input = [
      {
        id     = "123456789012"
        arn    = "arn:aws:organizations::000000000001:account/o-0abcd123ef/123456789012"
        name   = "account01"
        email  = "account01@example.org"
        status = "ACTIVE"
        state = "ACTIVE"
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
        state = "ACTIVE"
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
        state = "ACTIVE"
        tags   = {
          type = "prod"
        }
      },
    ]

    include = {
      name = {
        matcher = "startswith"
        values = null
      }
    }
  }

  command = plan

  expect_failures = [
    var.include.name.values,
  ]
}


run "filter_using__include_name__-_startswith_-_successfully_filter_for_single_entry_with_assertions_on_all_properties" {
  variables {
    input = [
      {
        id     = "123456789012"
        arn    = "arn:aws:organizations::000000000001:account/o-0abcd123ef/123456789012"
        name   = "prefix1-account01"
        email  = "account01@example.org"
        status = "ACTIVE"
        state = "ACTIVE"
        tags   = {
          type = "sandbox"
        }
      },
      {
        id     = "234567890123"
        arn    = "arn:aws:organizations::000000000001:account/o-0abcd123ef/234567890123"
        name   = "prefix2-account02"
        email  = "account02@example.org"
        status = "ACTIVE"
        state = "ACTIVE"
        tags   = {
          type = "nonprod"
        }
      },
      {
        id     = "345678901234"
        arn    = "arn:aws:organizations::000000000001:account/o-0abcd123ef/345678901234"
        name   = "prefix3-account03"
        email  = "account03@example.org"
        status = "ACTIVE"
        state = "ACTIVE"
        tags   = {
          type = "prod"
        }
      },
    ]

    include = {
      name = {
        matcher = "startswith"
        values = [
          "prefix2",
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
    condition = length(local.result["234567890123"]) == 1
    error_message = "Expected entry not found or contains more entries than expected."
  }

  assert {
    condition = local.result["234567890123"][0]["id"] == "234567890123"
    error_message = "Unexpected value."
  }

  assert {
    condition = local.result["234567890123"][0]["arn"] == "arn:aws:organizations::000000000001:account/o-0abcd123ef/234567890123"
    error_message = "Unexpected value."
  }

  assert {
    condition = local.result["234567890123"][0]["name"] == "prefix2-account02"
    error_message = "Unexpected value."
  }

  assert {
    condition = local.result["234567890123"][0]["email"] == "account02@example.org"
    error_message = "Unexpected value."
  }

  assert {
    condition = local.result["234567890123"][0]["status"] == "ACTIVE"
    error_message = "Unexpected value."
  }

  assert {
    condition = local.result["234567890123"][0]["state"] == "ACTIVE"
    error_message = "Unexpected value."
  }

  assert {
    condition = length(local.result["234567890123"][0]["tags"]) == 1
    error_message = "Only one tag is expected."
  }

  assert {
    condition = local.result["234567890123"][0]["tags"]["type"] == "nonprod"
    error_message = "Unexpected value."
  }
}

run "filter_using__include_name__-_startswith_-_successfully_filter_for_multiple_entries" {
  variables {
    input = [
      {
        id     = "123456789012"
        arn    = "arn:aws:organizations::000000000001:account/o-0abcd123ef/123456789012"
        name   = "prefix1-account01"
        email  = "account01@example.org"
        status = "ACTIVE"
        state = "ACTIVE"
        tags   = {
          type = "sandbox"
        }
      },
      {
        id     = "234567890123"
        arn    = "arn:aws:organizations::000000000001:account/o-0abcd123ef/234567890123"
        name   = "prefix2-account02"
        email  = "account02@example.org"
        status = "ACTIVE"
        state = "ACTIVE"
        tags   = {
          type = "nonprod"
        }
      },
      {
        id     = "345678901234"
        arn    = "arn:aws:organizations::000000000001:account/o-0abcd123ef/345678901234"
        name   = "prefix3-account03"
        email  = "account03@example.org"
        status = "ACTIVE"
        state = "ACTIVE"
        tags   = {
          type = "prod"
        }
      },
    ]

    include = {
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

run "filter_using__include_name__-_startswith_-_only_return_known_entry_if_you_filter_for_known_and_unknown_entry" {
  variables {
    input = [
      {
        id     = "123456789012"
        arn    = "arn:aws:organizations::000000000001:account/o-0abcd123ef/123456789012"
        name   = "prefix1-account01"
        email  = "account01@example.org"
        status = "ACTIVE"
        state = "ACTIVE"
        tags   = {
          type = "sandbox"
        }
      },
      {
        id     = "234567890123"
        arn    = "arn:aws:organizations::000000000001:account/o-0abcd123ef/234567890123"
        name   = "prefix2-account02"
        email  = "account02@example.org"
        status = "ACTIVE"
        state = "ACTIVE"
        tags   = {
          type = "nonprod"
        }
      },
      {
        id     = "345678901234"
        arn    = "arn:aws:organizations::000000000001:account/o-0abcd123ef/345678901234"
        name   = "prefix3-account03"
        email  = "account03@example.org"
        status = "ACTIVE"
        state = "ACTIVE"
        tags   = {
          type = "prod"
        }
      },
    ]

    include = {
      name = {
        matcher = "startswith"
        values = [
          "prefix1-",
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

run "filter_using__include_name__-_startswith_-_unknown_entry_returns_empty_list" {
  variables {
    input = [
      {
        id     = "123456789012"
        arn    = "arn:aws:organizations::000000000001:account/o-0abcd123ef/123456789012"
        name   = "account01"
        email  = "account01@example.org"
        status = "ACTIVE"
        state = "ACTIVE"
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
        state = "ACTIVE"
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
        state = "ACTIVE"
        tags   = {
          type = "prod"
        }
      },
    ]

    include = {
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
    condition = length(local.result) == 0
    error_message = "Expected to return an empty list if nothing matches."
  }
}

run "filter_using__include_name__-_startswith_-_empty_values_list_returns_empty_list" {
  variables {
    input = [
      {
        id     = "123456789012"
        arn    = "arn:aws:organizations::000000000001:account/o-0abcd123ef/123456789012"
        name   = "account01"
        email  = "account01@example.org"
        status = "ACTIVE"
        state = "ACTIVE"
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
        state = "ACTIVE"
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
        state = "ACTIVE"
        tags   = {
          type = "prod"
        }
      },
    ]

    include = {
      name = {
        matcher = "startswith"
        values = []
      }
    }
  }

  command = plan

  assert {
    condition = length(local.result) == 0
    error_message = "Expected to return an empty list if nothing matches."
  }
}


run "filter_using__include_name__-_endswith_-_successfully_filter_for_single_entry_with_assertions_on_all_properties" {
  variables {
    input = [
      {
        id     = "123456789012"
        arn    = "arn:aws:organizations::000000000001:account/o-0abcd123ef/123456789012"
        name   = "account01-suffix1"
        email  = "account01@example.org"
        status = "ACTIVE"
        state = "ACTIVE"
        tags   = {
          type = "sandbox"
        }
      },
      {
        id     = "234567890123"
        arn    = "arn:aws:organizations::000000000001:account/o-0abcd123ef/234567890123"
        name   = "account02-suffix2"
        email  = "account02@example.org"
        status = "ACTIVE"
        state = "ACTIVE"
        tags   = {
          type = "nonprod"
        }
      },
      {
        id     = "345678901234"
        arn    = "arn:aws:organizations::000000000001:account/o-0abcd123ef/345678901234"
        name   = "account03-suffix3"
        email  = "account03@example.org"
        status = "ACTIVE"
        state = "ACTIVE"
        tags   = {
          type = "prod"
        }
      },
    ]

    include = {
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
    condition = length(keys(local.result)) == 1
    error_message = "Expected 1 entry in search result."
  }

  assert {
    condition = length(local.result["234567890123"]) == 1
    error_message = "Expected entry not found or contains more entries than expected."
  }

  assert {
    condition = local.result["234567890123"][0]["id"] == "234567890123"
    error_message = "Unexpected value."
  }

  assert {
    condition = local.result["234567890123"][0]["arn"] == "arn:aws:organizations::000000000001:account/o-0abcd123ef/234567890123"
    error_message = "Unexpected value."
  }

  assert {
    condition = local.result["234567890123"][0]["name"] == "account02-suffix2"
    error_message = "Unexpected value."
  }

  assert {
    condition = local.result["234567890123"][0]["email"] == "account02@example.org"
    error_message = "Unexpected value."
  }

  assert {
    condition = local.result["234567890123"][0]["status"] == "ACTIVE"
    error_message = "Unexpected value."
  }

  assert {
    condition = local.result["234567890123"][0]["state"] == "ACTIVE"
    error_message = "Unexpected value."
  }

  assert {
    condition = length(local.result["234567890123"][0]["tags"]) == 1
    error_message = "Only one tag is expected."
  }

  assert {
    condition = local.result["234567890123"][0]["tags"]["type"] == "nonprod"
    error_message = "Unexpected value."
  }
}

run "filter_using__include_name__-_endswith_-_successfully_filter_for_multiple_entries" {
  variables {
    input = [
      {
        id     = "123456789012"
        arn    = "arn:aws:organizations::000000000001:account/o-0abcd123ef/123456789012"
        name   = "account01-suffix1"
        email  = "account01@example.org"
        status = "ACTIVE"
        state = "ACTIVE"
        tags   = {
          type = "sandbox"
        }
      },
      {
        id     = "234567890123"
        arn    = "arn:aws:organizations::000000000001:account/o-0abcd123ef/234567890123"
        name   = "account02-suffix2"
        email  = "account02@example.org"
        status = "ACTIVE"
        state = "ACTIVE"
        tags   = {
          type = "nonprod"
        }
      },
      {
        id     = "345678901234"
        arn    = "arn:aws:organizations::000000000001:account/o-0abcd123ef/345678901234"
        name   = "account03-suffix3"
        email  = "account03@example.org"
        status = "ACTIVE"
        state = "ACTIVE"
        tags   = {
          type = "prod"
        }
      },
    ]

    include = {
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

run "filter_using__include_name__-_endswith_-_only_return_known_entry_if_you_filter_for_known_and_unknown_entry" {
  variables {
    input = [
      {
        id     = "123456789012"
        arn    = "arn:aws:organizations::000000000001:account/o-0abcd123ef/123456789012"
        name   = "account01-suffix1"
        email  = "account01@example.org"
        status = "ACTIVE"
        state = "ACTIVE"
        tags   = {
          type = "sandbox"
        }
      },
      {
        id     = "234567890123"
        arn    = "arn:aws:organizations::000000000001:account/o-0abcd123ef/234567890123"
        name   = "account02-suffix2"
        email  = "account02@example.org"
        status = "ACTIVE"
        state = "ACTIVE"
        tags   = {
          type = "nonprod"
        }
      },
      {
        id     = "345678901234"
        arn    = "arn:aws:organizations::000000000001:account/o-0abcd123ef/345678901234"
        name   = "account03-suffix3"
        email  = "account03@example.org"
        status = "ACTIVE"
        state = "ACTIVE"
        tags   = {
          type = "prod"
        }
      },
    ]

    include = {
      name = {
        matcher = "endswith"
        values = [
          "-suffix1",
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

run "filter_using__include_name__-_endswith_-_unknown_entry_returns_empty_list" {
  variables {
    input = [
      {
        id     = "123456789012"
        arn    = "arn:aws:organizations::000000000001:account/o-0abcd123ef/123456789012"
        name   = "account01"
        email  = "account01@example.org"
        status = "ACTIVE"
        state = "ACTIVE"
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
        state = "ACTIVE"
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
        state = "ACTIVE"
        tags   = {
          type = "prod"
        }
      },
    ]

    include = {
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
    condition = length(local.result) == 0
    error_message = "Expected to return an empty list if nothing matches."
  }
}

run "filter_using__include_name__-_endswith_-_empty_values_list_returns_empty_list" {
  variables {
    input = [
      {
        id     = "123456789012"
        arn    = "arn:aws:organizations::000000000001:account/o-0abcd123ef/123456789012"
        name   = "account01"
        email  = "account01@example.org"
        status = "ACTIVE"
        state = "ACTIVE"
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
        state = "ACTIVE"
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
        state = "ACTIVE"
        tags   = {
          type = "prod"
        }
      },
    ]

    include = {
      name = {
        matcher = "endswith"
        values = []
      }
    }
  }

  command = plan

  assert {
    condition = length(local.result) == 0
    error_message = "Expected to return an empty list if nothing matches."
  }
}


run "filter_using__include_name__-_equals_-_successfully_filter_for_single_entry_with_assertions_on_all_properties" {
  variables {
    input = [
      {
        id     = "123456789012"
        arn    = "arn:aws:organizations::000000000001:account/o-0abcd123ef/123456789012"
        name   = "account01"
        email  = "account01@example.org"
        status = "ACTIVE"
        state = "ACTIVE"
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
        state = "ACTIVE"
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
        state = "ACTIVE"
        tags   = {
          type = "prod"
        }
      },
    ]

    include = {
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
    condition = length(keys(local.result)) == 1
    error_message = "Expected 1 entry in search result."
  }

  assert {
    condition = length(local.result["234567890123"]) == 1
    error_message = "Expected entry not found or contains more entries than expected."
  }

  assert {
    condition = local.result["234567890123"][0]["id"] == "234567890123"
    error_message = "Unexpected value."
  }

  assert {
    condition = local.result["234567890123"][0]["arn"] == "arn:aws:organizations::000000000001:account/o-0abcd123ef/234567890123"
    error_message = "Unexpected value."
  }

  assert {
    condition = local.result["234567890123"][0]["name"] == "account02"
    error_message = "Unexpected value."
  }

  assert {
    condition = local.result["234567890123"][0]["email"] == "account02@example.org"
    error_message = "Unexpected value."
  }

  assert {
    condition = local.result["234567890123"][0]["status"] == "ACTIVE"
    error_message = "Unexpected value."
  }

  assert {
    condition = local.result["234567890123"][0]["state"] == "ACTIVE"
    error_message = "Unexpected value."
  }

  assert {
    condition = length(local.result["234567890123"][0]["tags"]) == 1
    error_message = "Only one tag is expected."
  }

  assert {
    condition = local.result["234567890123"][0]["tags"]["type"] == "nonprod"
    error_message = "Unexpected value."
  }
}

run "filter_using__include_name__-_equals_-_successfully_filter_for_multiple_entries" {
  variables {
    input = [
      {
        id     = "123456789012"
        arn    = "arn:aws:organizations::000000000001:account/o-0abcd123ef/123456789012"
        name   = "account01"
        email  = "account01@example.org"
        status = "ACTIVE"
        state = "ACTIVE"
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
        state = "ACTIVE"
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
        state = "ACTIVE"
        tags   = {
          type = "prod"
        }
      },
    ]

    include = {
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

run "filter_using__include_name__-_equals_-_only_return_known_entry_if_you_filter_for_known_and_unknown_entry" {
  variables {
    input = [
      {
        id     = "123456789012"
        arn    = "arn:aws:organizations::000000000001:account/o-0abcd123ef/123456789012"
        name   = "account01"
        email  = "account01@example.org"
        status = "ACTIVE"
        state = "ACTIVE"
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
        state = "ACTIVE"
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
        state = "ACTIVE"
        tags   = {
          type = "prod"
        }
      },
    ]

    include = {
      name = {
        matcher = "equals"
        values = [
          "account01",
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

run "filter_using__include_name__-_equals_-_unknown_entry_returns_empty_list" {
  variables {
    input = [
      {
        id     = "123456789012"
        arn    = "arn:aws:organizations::000000000001:account/o-0abcd123ef/123456789012"
        name   = "account01"
        email  = "account01@example.org"
        status = "ACTIVE"
        state = "ACTIVE"
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
        state = "ACTIVE"
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
        state = "ACTIVE"
        tags   = {
          type = "prod"
        }
      },
    ]

    include = {
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
    condition = length(local.result) == 0
    error_message = "Expected to return an empty list if nothing matches."
  }
}

run "filter_using__include_name__-_equals_-_empty_values_list_returns_empty_list" {
  variables {
    input = [
      {
        id     = "123456789012"
        arn    = "arn:aws:organizations::000000000001:account/o-0abcd123ef/123456789012"
        name   = "prefix1-account01"
        email  = "account01@example.org"
        status = "ACTIVE"
        state = "ACTIVE"
        tags   = {
          type = "sandbox"
        }
      },
      {
        id     = "234567890123"
        arn    = "arn:aws:organizations::000000000001:account/o-0abcd123ef/234567890123"
        name   = "prefix2-account02"
        email  = "account02@example.org"
        status = "ACTIVE"
        state = "ACTIVE"
        tags   = {
          type = "nonprod"
        }
      },
      {
        id     = "345678901234"
        arn    = "arn:aws:organizations::000000000001:account/o-0abcd123ef/345678901234"
        name   = "prefix3-account03"
        email  = "account03@example.org"
        status = "ACTIVE"
        state = "ACTIVE"
        tags   = {
          type = "prod"
        }
      },
    ]

    include = {
      name = {
        matcher = "equals"
        values = []
      }
    }
  }

  command = plan

  assert {
    condition = length(local.result) == 0
    error_message = "Expected to return an empty list if nothing matches."
  }
}


run "filter_using__include_name__-_contains_-_successfully_filter_for_single_entry_with_assertions_on_all_properties" {
  variables {
    input = [
      {
        id     = "123456789012"
        arn    = "arn:aws:organizations::000000000001:account/o-0abcd123ef/123456789012"
        name   = "prefix1-account01"
        email  = "account01@example.org"
        status = "ACTIVE"
        state = "ACTIVE"
        tags   = {
          type = "sandbox"
        }
      },
      {
        id     = "234567890123"
        arn    = "arn:aws:organizations::000000000001:account/o-0abcd123ef/234567890123"
        name   = "prefix2-account02"
        email  = "account02@example.org"
        status = "ACTIVE"
        state = "ACTIVE"
        tags   = {
          type = "nonprod"
        }
      },
      {
        id     = "345678901234"
        arn    = "arn:aws:organizations::000000000001:account/o-0abcd123ef/345678901234"
        name   = "prefix3-account03"
        email  = "account03@example.org"
        status = "ACTIVE"
        state = "ACTIVE"
        tags   = {
          type = "prod"
        }
      },
    ]

    include = {
      name = {
        matcher = "contains"
        values = [
          "2-a",
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
    condition = length(local.result["234567890123"]) == 1
    error_message = "Expected entry not found or contains more entries than expected."
  }

  assert {
    condition = local.result["234567890123"][0]["id"] == "234567890123"
    error_message = "Unexpected value."
  }

  assert {
    condition = local.result["234567890123"][0]["arn"] == "arn:aws:organizations::000000000001:account/o-0abcd123ef/234567890123"
    error_message = "Unexpected value."
  }

  assert {
    condition = local.result["234567890123"][0]["name"] == "prefix2-account02"
    error_message = "Unexpected value."
  }

  assert {
    condition = local.result["234567890123"][0]["email"] == "account02@example.org"
    error_message = "Unexpected value."
  }

  assert {
    condition = local.result["234567890123"][0]["status"] == "ACTIVE"
    error_message = "Unexpected value."
  }

  assert {
    condition = local.result["234567890123"][0]["state"] == "ACTIVE"
    error_message = "Unexpected value."
  }

  assert {
    condition = length(local.result["234567890123"][0]["tags"]) == 1
    error_message = "Only one tag is expected."
  }

  assert {
    condition = local.result["234567890123"][0]["tags"]["type"] == "nonprod"
    error_message = "Unexpected value."
  }
}

run "filter_using__include_name__-_contains_-_successfully_filter_for_multiple_entries" {
  variables {
    input = [
      {
        id     = "123456789012"
        arn    = "arn:aws:organizations::000000000001:account/o-0abcd123ef/123456789012"
        name   = "prefix1-account01"
        email  = "account01@example.org"
        status = "ACTIVE"
        state = "ACTIVE"
        tags   = {
          type = "sandbox"
        }
      },
      {
        id     = "234567890123"
        arn    = "arn:aws:organizations::000000000001:account/o-0abcd123ef/234567890123"
        name   = "prefix2-account02"
        email  = "account02@example.org"
        status = "ACTIVE"
        state = "ACTIVE"
        tags   = {
          type = "nonprod"
        }
      },
      {
        id     = "345678901234"
        arn    = "arn:aws:organizations::000000000001:account/o-0abcd123ef/345678901234"
        name   = "prefix3-account03"
        email  = "account03@example.org"
        status = "ACTIVE"
        state = "ACTIVE"
        tags   = {
          type = "prod"
        }
      },
    ]

    include = {
      name = {
        matcher = "contains"
        values = [
          "1-",
          "3-",
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

run "filter_using__include_name__-_contains_-_only_return_known_entry_if_you_filter_for_known_and_unknown_entry" {
  variables {
    input = [
      {
        id     = "123456789012"
        arn    = "arn:aws:organizations::000000000001:account/o-0abcd123ef/123456789012"
        name   = "prefix1-account01"
        email  = "account01@example.org"
        status = "ACTIVE"
        state = "ACTIVE"
        tags   = {
          type = "sandbox"
        }
      },
      {
        id     = "234567890123"
        arn    = "arn:aws:organizations::000000000001:account/o-0abcd123ef/234567890123"
        name   = "prefix2-account02"
        email  = "account02@example.org"
        status = "ACTIVE"
        state = "ACTIVE"
        tags   = {
          type = "nonprod"
        }
      },
      {
        id     = "345678901234"
        arn    = "arn:aws:organizations::000000000001:account/o-0abcd123ef/345678901234"
        name   = "prefix3-account03"
        email  = "account03@example.org"
        status = "ACTIVE"
        state = "ACTIVE"
        tags   = {
          type = "prod"
        }
      },
    ]

    include = {
      name = {
        matcher = "contains"
        values = [
          "2-a",
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
    condition = length(local.result["234567890123"]) == 1
    error_message = "Expected entry not found or contains more entries than expected."
  }
}

run "filter_using__include_name__-_contains_-_unknown_entry_returns_empty_list" {
  variables {
    input = [
      {
        id     = "123456789012"
        arn    = "arn:aws:organizations::000000000001:account/o-0abcd123ef/123456789012"
        name   = "account01"
        email  = "account01@example.org"
        status = "ACTIVE"
        state = "ACTIVE"
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
        state = "ACTIVE"
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
        state = "ACTIVE"
        tags   = {
          type = "prod"
        }
      },
    ]

    include = {
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
    condition = length(local.result) == 0
    error_message = "Expected to return an empty list if nothing matches."
  }
}

run "filter_using__include_name__-_contains_-_empty_values_list_returns_empty_list" {
  variables {
    input = [
      {
        id     = "123456789012"
        arn    = "arn:aws:organizations::000000000001:account/o-0abcd123ef/123456789012"
        name   = "account01"
        email  = "account01@example.org"
        status = "ACTIVE"
        state = "ACTIVE"
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
        state = "ACTIVE"
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
        state = "ACTIVE"
        tags   = {
          type = "prod"
        }
      },
    ]

    include = {
      name = {
        matcher = "contains"
        values = []
      }
    }
  }

  command = plan

  assert {
    condition = length(local.result) == 0
    error_message = "Expected to return an empty list if nothing matches."
  }
}


run "filter_using__include_name__-_regex_-_successfully_filter_for_single_entry_with_assertions_on_all_properties" {
  variables {
    input = [
      {
        id     = "123456789012"
        arn    = "arn:aws:organizations::000000000001:account/o-0abcd123ef/123456789012"
        name   = "prefix1-account01-foo-ABCD-bar-suffix"
        email  = "account01@example.org"
        status = "ACTIVE"
        state = "ACTIVE"
        tags   = {
          type = "sandbox"
        }
      },
      {
        id     = "234567890123"
        arn    = "arn:aws:organizations::000000000001:account/o-0abcd123ef/234567890123"
        name   = "prefix2-account02-foo-4567-bar-suffix"
        email  = "account02@example.org"
        status = "ACTIVE"
        state = "ACTIVE"
        tags   = {
          type = "nonprod"
        }
      },
      {
        id     = "345678901234"
        arn    = "arn:aws:organizations::000000000001:account/o-0abcd123ef/345678901234"
        name   = "prefix3-account03-foo-F7K1-bar-suffix"
        email  = "account03@example.org"
        status = "ACTIVE"
        state = "ACTIVE"
        tags   = {
          type = "prod"
        }
      },
    ]

    include = {
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
    condition = length(keys(local.result)) == 1
    error_message = "Expected 1 entry in search result."
  }

  assert {
    condition = length(local.result["234567890123"]) == 1
    error_message = "Expected entry not found or contains more entries than expected."
  }

  assert {
    condition = local.result["234567890123"][0]["id"] == "234567890123"
    error_message = "Unexpected value."
  }

  assert {
    condition = local.result["234567890123"][0]["arn"] == "arn:aws:organizations::000000000001:account/o-0abcd123ef/234567890123"
    error_message = "Unexpected value."
  }

  assert {
    condition = local.result["234567890123"][0]["name"] == "prefix2-account02-foo-4567-bar-suffix"
    error_message = "Unexpected value."
  }

  assert {
    condition = local.result["234567890123"][0]["email"] == "account02@example.org"
    error_message = "Unexpected value."
  }

  assert {
    condition = local.result["234567890123"][0]["status"] == "ACTIVE"
    error_message = "Unexpected value."
  }

  assert {
    condition = local.result["234567890123"][0]["state"] == "ACTIVE"
    error_message = "Unexpected value."
  }

  assert {
    condition = length(local.result["234567890123"][0]["tags"]) == 1
    error_message = "Only one tag is expected."
  }

  assert {
    condition = local.result["234567890123"][0]["tags"]["type"] == "nonprod"
    error_message = "Unexpected value."
  }
}

run "filter_using__include_name__-_regex_-_successfully_filter_for_multiple_entries" {
  variables {
    input = [
      {
        id     = "123456789012"
        arn    = "arn:aws:organizations::000000000001:account/o-0abcd123ef/123456789012"
        name   = "prefix1-account01-foo-ABCD-bar-suffix"
        email  = "account01@example.org"
        status = "ACTIVE"
        state = "ACTIVE"
        tags   = {
          type = "sandbox"
        }
      },
      {
        id     = "234567890123"
        arn    = "arn:aws:organizations::000000000001:account/o-0abcd123ef/234567890123"
        name   = "prefix2-account02-foo-4567-bar-suffix"
        email  = "account02@example.org"
        status = "ACTIVE"
        state = "ACTIVE"
        tags   = {
          type = "nonprod"
        }
      },
      {
        id     = "345678901234"
        arn    = "arn:aws:organizations::000000000001:account/o-0abcd123ef/345678901234"
        name   = "prefix3-account03-foo-F7K1-bar-suffix"
        email  = "account03@example.org"
        status = "ACTIVE"
        state = "ACTIVE"
        tags   = {
          type = "prod"
        }
      },
    ]

    include = {
      name = {
        matcher = "regex"
        values = [
          "[A-D]{4}",
          "3.*?F",
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

run "filter_using__include_name__-_regex_-_only_return_known_entry_if_you_filter_for_known_and_unknown_entry" {
  variables {
    input = [
      {
        id     = "123456789012"
        arn    = "arn:aws:organizations::000000000001:account/o-0abcd123ef/123456789012"
        name   = "prefix1-account01-foo-ABCD-bar-suffix"
        email  = "account01@example.org"
        status = "ACTIVE"
        state = "ACTIVE"
        tags   = {
          type = "sandbox"
        }
      },
      {
        id     = "234567890123"
        arn    = "arn:aws:organizations::000000000001:account/o-0abcd123ef/234567890123"
        name   = "prefix2-account02-foo-4567-bar-suffix"
        email  = "account02@example.org"
        status = "ACTIVE"
        state = "ACTIVE"
        tags   = {
          type = "nonprod"
        }
      },
      {
        id     = "345678901234"
        arn    = "arn:aws:organizations::000000000001:account/o-0abcd123ef/345678901234"
        name   = "prefix3-account03-foo-F7K1-bar-suffix"
        email  = "account03@example.org"
        status = "ACTIVE"
        state = "ACTIVE"
        tags   = {
          type = "prod"
        }
      },
    ]

    include = {
      name = {
        matcher = "regex"
        values = [
          "([A-Z]\\d){2}",
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

run "filter_using__include_name__-_regex_-_unknown_entry_returns_empty_list" {
  variables {
    input = [
      {
        id     = "123456789012"
        arn    = "arn:aws:organizations::000000000001:account/o-0abcd123ef/123456789012"
        name   = "prefix1-account01-foo-ABCD-bar-suffix"
        email  = "account01@example.org"
        status = "ACTIVE"
        state = "ACTIVE"
        tags   = {
          type = "sandbox"
        }
      },
      {
        id     = "234567890123"
        arn    = "arn:aws:organizations::000000000001:account/o-0abcd123ef/234567890123"
        name   = "prefix2-account02-foo-4567-bar-suffix"
        email  = "account02@example.org"
        status = "ACTIVE"
        state = "ACTIVE"
        tags   = {
          type = "nonprod"
        }
      },
      {
        id     = "345678901234"
        arn    = "arn:aws:organizations::000000000001:account/o-0abcd123ef/345678901234"
        name   = "prefix3-account03-foo-F7K1-bar-suffix"
        email  = "account03@example.org"
        status = "ACTIVE"
        state = "ACTIVE"
        tags   = {
          type = "prod"
        }
      },
    ]

    include = {
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
    condition = length(local.result) == 0
    error_message = "Expected to return an empty list if nothing matches."
  }
}

run "filter_using__include_name__-_regex_-_empty_values_list_returns_empty_list" {
  variables {
    input = [
      {
        id     = "123456789012"
        arn    = "arn:aws:organizations::000000000001:account/o-0abcd123ef/123456789012"
        name   = "prefix1-account01-foo-ABCD-bar-suffix"
        email  = "account01@example.org"
        status = "ACTIVE"
        state = "ACTIVE"
        tags   = {
          type = "sandbox"
        }
      },
      {
        id     = "234567890123"
        arn    = "arn:aws:organizations::000000000001:account/o-0abcd123ef/234567890123"
        name   = "prefix2-account02-foo-4567-bar-suffix"
        email  = "account02@example.org"
        status = "ACTIVE"
        state = "ACTIVE"
        tags   = {
          type = "nonprod"
        }
      },
      {
        id     = "345678901234"
        arn    = "arn:aws:organizations::000000000001:account/o-0abcd123ef/345678901234"
        name   = "prefix3-account03-foo-F7K1-bar-suffix"
        email  = "account03@example.org"
        status = "ACTIVE"
        state = "ACTIVE"
        tags   = {
          type = "prod"
        }
      },
    ]

    include = {
      name = {
        matcher = "regex"
        values = []
      }
    }
  }

  command = plan

  assert {
    condition = length(local.result) == 0
    error_message = "Expected to return an empty list if nothing matches."
  }
}