run "filter_using_include.name.matcher_-_throws_exception_for_null" {
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
    ]

    include = {
      name = {
        matcher = null
        values = ["account04"]
      }
    }
  }

  command = plan

  expect_failures = [
    var.include.name.matcher,
  ]
}

run "filter_using_include.name.matcher_-_throws_exception_for_invalid_value" {
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
    ]

    include = {
      name = {
        matcher = "unknown"
        values = ["account04"]
      }
    }
  }

  command = plan

  expect_failures = [
    var.include.name.matcher,
  ]
}

run "filter_using_include.name.matcher_-_throws_exception_for_valid_value,_but_in_lower_case" {
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
    ]

    include = {
      name = {
        matcher = "STARTSWITH"
        values = ["account01"]
      }
    }
  }

  command = plan

  expect_failures = [
    var.include.name.matcher,
  ]
}


run "filter_using_include.name.values_-_throws_exception_for_null" {
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


run "filter_using_include.name_-_startswith_-_successfully_filter_for_single_entry_with_assertions_on_all_properties" {
  variables {
    input = [
      {
        id     = "123456789012"
        arn    = "arn:aws:organizations::000000000001:account/o-0abcd123ef/123456789012"
        name   = "prefix1-account01"
        email  = "account01@example.org"
        status = "ACTIVE"
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
    condition = length(keys(local.search_result)) == 1
    error_message = "Expected 1 entry in search result."
  }

  assert {
    condition = length(local.search_result["234567890123"]) == 1
    error_message = "Expected entry not found or contains more entries than expected."
  }

  assert {
    condition = local.search_result["234567890123"][0]["id"] == "234567890123"
    error_message = "Unexpected value."
  }

  assert {
    condition = local.search_result["234567890123"][0]["arn"] == "arn:aws:organizations::000000000001:account/o-0abcd123ef/234567890123"
    error_message = "Unexpected value."
  }

  assert {
    condition = local.search_result["234567890123"][0]["name"] == "prefix2-account02"
    error_message = "Unexpected value."
  }

  assert {
    condition = local.search_result["234567890123"][0]["email"] == "account02@example.org"
    error_message = "Unexpected value."
  }

  assert {
    condition = local.search_result["234567890123"][0]["status"] == "ACTIVE"
    error_message = "Unexpected value."
  }

  assert {
    condition = length(local.search_result["234567890123"][0]["tags"]) == 1
    error_message = "Only one tag is expected."
  }

  assert {
    condition = local.search_result["234567890123"][0]["tags"]["type"] == "nonprod"
    error_message = "Unexpected value."
  }
}

run "filter_using_include.name_-_startswith_-_successfully_filter_for_multiple_entries" {
  variables {
    input = [
      {
        id     = "123456789012"
        arn    = "arn:aws:organizations::000000000001:account/o-0abcd123ef/123456789012"
        name   = "prefix1-account01"
        email  = "account01@example.org"
        status = "ACTIVE"
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
    condition = length(keys(local.search_result)) == 2
    error_message = "Expected 2 entries in search result."
  }

  assert {
    condition = length(local.search_result["123456789012"]) == 1
    error_message = "Expected entry not found or contains more entries than expected."
  }

  assert {
    condition = length(local.search_result["345678901234"]) == 1
    error_message = "Expected entry not found or contains more entries than expected."
  }
}

run "filter_using_include.name_-_startswith_-_only_return_known_entry_if_you_filter_for_known_and_unknown_entry" {
  variables {
    input = [
      {
        id     = "123456789012"
        arn    = "arn:aws:organizations::000000000001:account/o-0abcd123ef/123456789012"
        name   = "prefix1-account01"
        email  = "account01@example.org"
        status = "ACTIVE"
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
          "error-",
        ]
      }
    }
  }

  command = plan

  assert {
    condition = length(keys(local.search_result)) == 1
    error_message = "Expected 1 entry in search result."
  }

  assert {
    condition = length(local.search_result["123456789012"]) == 1
    error_message = "Expected entry not found or contains more entries than expected."
  }
}

run "filter_using_include.name_-_startswith_-_unknown_entry_returns_empty_list" {
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
    ]

    include = {
      name = {
        matcher = "startswith"
        values = [
          "error-",
        ]
      }
    }
  }

  command = plan

  assert {
    condition = length(local.search_result) == 0
    error_message = "Expected to return an empty list if nothing matches."
  }
}

run "filter_using_include.name_-_startswith_-_empty_values_list_returns_empty_list" {
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
    condition = length(local.search_result) == 0
    error_message = "Expected to return an empty list if nothing matches."
  }
}


run "filter_using_include.name_-_endswith_-_successfully_filter_for_single_entry_with_assertions_on_all_properties" {
  variables {
    input = [
      {
        id     = "123456789012"
        arn    = "arn:aws:organizations::000000000001:account/o-0abcd123ef/123456789012"
        name   = "account01-suffix1"
        email  = "account01@example.org"
        status = "ACTIVE"
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
    condition = length(keys(local.search_result)) == 1
    error_message = "Expected 1 entry in search result."
  }

  assert {
    condition = length(local.search_result["234567890123"]) == 1
    error_message = "Expected entry not found or contains more entries than expected."
  }

  assert {
    condition = local.search_result["234567890123"][0]["id"] == "234567890123"
    error_message = "Unexpected value."
  }

  assert {
    condition = local.search_result["234567890123"][0]["arn"] == "arn:aws:organizations::000000000001:account/o-0abcd123ef/234567890123"
    error_message = "Unexpected value."
  }

  assert {
    condition = local.search_result["234567890123"][0]["name"] == "account02-suffix2"
    error_message = "Unexpected value."
  }

  assert {
    condition = local.search_result["234567890123"][0]["email"] == "account02@example.org"
    error_message = "Unexpected value."
  }

  assert {
    condition = local.search_result["234567890123"][0]["status"] == "ACTIVE"
    error_message = "Unexpected value."
  }

  assert {
    condition = length(local.search_result["234567890123"][0]["tags"]) == 1
    error_message = "Only one tag is expected."
  }

  assert {
    condition = local.search_result["234567890123"][0]["tags"]["type"] == "nonprod"
    error_message = "Unexpected value."
  }
}

run "filter_using_include.name_-_endswith_-_successfully_filter_for_multiple_entries" {
  variables {
    input = [
      {
        id     = "123456789012"
        arn    = "arn:aws:organizations::000000000001:account/o-0abcd123ef/123456789012"
        name   = "account01-suffix1"
        email  = "account01@example.org"
        status = "ACTIVE"
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
    condition = length(keys(local.search_result)) == 2
    error_message = "Expected 2 entries in search result."
  }

  assert {
    condition = length(local.search_result["123456789012"]) == 1
    error_message = "Expected entry not found or contains more entries than expected."
  }

  assert {
    condition = length(local.search_result["345678901234"]) == 1
    error_message = "Expected entry not found or contains more entries than expected."
  }
}

run "filter_using_include.name_-_endswith_-_only_return_known_entry_if_you_filter_for_known_and_unknown_entry" {
  variables {
    input = [
      {
        id     = "123456789012"
        arn    = "arn:aws:organizations::000000000001:account/o-0abcd123ef/123456789012"
        name   = "account01-suffix1"
        email  = "account01@example.org"
        status = "ACTIVE"
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
          "-error",
        ]
      }
    }
  }

  command = plan

  assert {
    condition = length(keys(local.search_result)) == 1
    error_message = "Expected 1 entry in search result."
  }

  assert {
    condition = length(local.search_result["123456789012"]) == 1
    error_message = "Expected entry not found or contains more entries than expected."
  }
}

run "filter_using_include.name_-_endswith_-_unknown_entry_returns_empty_list" {
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
    ]

    include = {
      name = {
        matcher = "startswith"
        values = [
          "-error",
        ]
      }
    }
  }

  command = plan

  assert {
    condition = length(local.search_result) == 0
    error_message = "Expected to return an empty list if nothing matches."
  }
}

run "filter_using_include.name_-_endswith_-_empty_values_list_returns_empty_list" {
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
    condition = length(local.search_result) == 0
    error_message = "Expected to return an empty list if nothing matches."
  }
}


run "filter_using_include.name_-_equals_-_successfully_filter_for_single_entry_with_assertions_on_all_properties" {
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
    condition = length(keys(local.search_result)) == 1
    error_message = "Expected 1 entry in search result."
  }

  assert {
    condition = length(local.search_result["234567890123"]) == 1
    error_message = "Expected entry not found or contains more entries than expected."
  }

  assert {
    condition = local.search_result["234567890123"][0]["id"] == "234567890123"
    error_message = "Unexpected value."
  }

  assert {
    condition = local.search_result["234567890123"][0]["arn"] == "arn:aws:organizations::000000000001:account/o-0abcd123ef/234567890123"
    error_message = "Unexpected value."
  }

  assert {
    condition = local.search_result["234567890123"][0]["name"] == "account02"
    error_message = "Unexpected value."
  }

  assert {
    condition = local.search_result["234567890123"][0]["email"] == "account02@example.org"
    error_message = "Unexpected value."
  }

  assert {
    condition = local.search_result["234567890123"][0]["status"] == "ACTIVE"
    error_message = "Unexpected value."
  }

  assert {
    condition = length(local.search_result["234567890123"][0]["tags"]) == 1
    error_message = "Only one tag is expected."
  }

  assert {
    condition = local.search_result["234567890123"][0]["tags"]["type"] == "nonprod"
    error_message = "Unexpected value."
  }
}

run "filter_using_include.name_-_equals_-_successfully_filter_for_multiple_entries" {
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
    condition = length(keys(local.search_result)) == 2
    error_message = "Expected 2 entries in search result."
  }

  assert {
    condition = length(local.search_result["123456789012"]) == 1
    error_message = "Expected entry not found or contains more entries than expected."
  }

  assert {
    condition = length(local.search_result["345678901234"]) == 1
    error_message = "Expected entry not found or contains more entries than expected."
  }
}

run "filter_using_include.name_-_equals_-_only_return_known_entry_if_you_filter_for_known_and_unknown_entry" {
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
    ]

    include = {
      name = {
        matcher = "equals"
        values = [
          "account01",
          "error",
        ]
      }
    }
  }

  command = plan

  assert {
    condition = length(keys(local.search_result)) == 1
    error_message = "Expected 1 entry in search result."
  }

  assert {
    condition = length(local.search_result["123456789012"]) == 1
    error_message = "Expected entry not found or contains more entries than expected."
  }
}

run "filter_using_include.name_-_equals_-_unknown_entry_returns_empty_list" {
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
    ]

    include = {
      name = {
        matcher = "endswith"
        values = [
          "account04",
        ]
      }
    }
  }

  command = plan

  assert {
    condition = length(local.search_result) == 0
    error_message = "Expected to return an empty list if nothing matches."
  }
}

run "filter_using_include.name_-_equals_-_empty_values_list_returns_empty_list" {
  variables {
    input = [
      {
        id     = "123456789012"
        arn    = "arn:aws:organizations::000000000001:account/o-0abcd123ef/123456789012"
        name   = "prefix1-account01"
        email  = "account01@example.org"
        status = "ACTIVE"
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
    condition = length(local.search_result) == 0
    error_message = "Expected to return an empty list if nothing matches."
  }
}