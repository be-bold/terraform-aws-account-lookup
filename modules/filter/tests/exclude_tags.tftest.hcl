run "filter_using_exclude.tags_-_successfully_filter_for_single_entry_with_assertions_on_all_properties" {
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

    exclude = {
      tags = {
        type = [
          "sandbox",
          "prod",
        ]
      }
    }
  }

  command = plan

  assert {
    condition     = length(keys(local.search_result)) == 1
    error_message = "Expected 1 entry in search result."
  }

  assert {
    condition     = length(local.search_result["234567890123"]) == 1
    error_message = "Expected entry not found or contains more entries than expected."
  }

  assert {
    condition     = local.search_result["234567890123"][0]["id"] == "234567890123"
    error_message = "Unexpected value."
  }

  assert {
    condition     = local.search_result["234567890123"][0]["arn"] == "arn:aws:organizations::000000000001:account/o-0abcd123ef/234567890123"
    error_message = "Unexpected value."
  }

  assert {
    condition     = local.search_result["234567890123"][0]["name"] == "account02"
    error_message = "Unexpected value."
  }

  assert {
    condition     = local.search_result["234567890123"][0]["email"] == "account02@example.org"
    error_message = "Unexpected value."
  }

  assert {
    condition     = local.search_result["234567890123"][0]["status"] == "ACTIVE"
    error_message = "Unexpected value."
  }

  assert {
    condition     = length(local.search_result["234567890123"][0]["tags"]) == 1
    error_message = "Only one tag is expected."
  }

  assert {
    condition     = local.search_result["234567890123"][0]["tags"]["type"] == "nonprod"
    error_message = "Unexpected value."
  }
}

run "filter_using_exclude.tags_-_successfully_filter_for_multiple_entries" {
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

    exclude = {
      tags = {
        type = [
          "nonprod",
        ]
      }
    }
  }

  command = plan

  assert {
    condition     = length(keys(local.search_result)) == 2
    error_message = "Expected 2 entries in search result."
  }

  assert {
    condition     = length(local.search_result["123456789012"]) == 1
    error_message = "Expected entry not found or contains more entries than expected."
  }

  assert {
    condition     = length(local.search_result["345678901234"]) == 1
    error_message = "Expected entry not found or contains more entries than expected."
  }
}

run "filter_using_exclude.tags_-_successfully_filter_for_single_entry_using_multiple_tags" {
  variables {
    input = [
      {
        id     = "123456789012"
        arn    = "arn:aws:organizations::000000000001:account/o-0abcd123ef/123456789012"
        name   = "account01"
        email  = "account01@example.org"
        status = "ACTIVE"
        tags   = {
          type = "nonprod"
          team = "team3"
        }
      },
      {
        id     = "234567890123"
        arn    = "arn:aws:organizations::000000000001:account/o-0abcd123ef/234567890123"
        name   = "account02"
        email  = "account02@example.org"
        status = "ACTIVE"
        tags   = {
          type = "sandbox"
          team = "team2"
        }
      },
      {
        id     = "345678901234"
        arn    = "arn:aws:organizations::000000000001:account/o-0abcd123ef/345678901234"
        name   = "account03"
        email  = "account03@example.org"
        status = "ACTIVE"
        tags   = {
          type = "nonprod"
          team = "team3"
        }
      },
    ]

    exclude = {
      tags = {
        type = [
          "nonprod",
        ]
        team = [
          "team3",
        ]
      }
    }
  }

  command = plan

  assert {
    condition     = length(keys(local.search_result)) == 1
    error_message = "Expected 1 entry in search result."
  }

  assert {
    condition     = length(local.search_result["234567890123"]) == 1
    error_message = "Expected entry not found or contains more entries than expected."
  }
}

run "filter_using_exclude.tags_-_only_exclude_known_entries_with_known_values_if_you_filter_for_known_and_unknown_entry" {
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

    exclude = {
      tags = {
        type = [
          "nonprod",
          "prod",
          "error",
        ]
      }
    }
  }

  command = plan

  assert {
    condition     = length(keys(local.search_result)) == 1
    error_message = "Expected 1 entry in search result."
  }

  assert {
    condition     = length(local.search_result["123456789012"]) == 1
    error_message = "Expected entry not found or contains more entries than expected."
  }
}

run "filter_using_exclude.tags_-_only_exclude_known_entries_with_known_values_for_existing_tags" {
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
          team = "team3"
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
          type = "sandbox"
        }
      },
    ]

    exclude = {
      tags = {
        type = [
          "sandbox",
        ]
        team = [
          "team3",
        ]
      }
    }
  }

  command = plan

  assert {
    condition     = length(keys(local.search_result)) == 2
    error_message = "Expected 2 entries in search result."
  }

  assert {
    condition     = length(local.search_result["234567890123"]) == 1
    error_message = "Expected entry not found or contains more entries than expected."
  }

  assert {
    condition     = length(local.search_result["345678901234"]) == 1
    error_message = "Expected entry not found or contains more entries than expected."
  }
}

run "filter_using_exclude.tags_-_unknown_key_doesn't_exclude_anything" {
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

    exclude = {
      tags = {
        unknown = [
          "prod",
        ]
      }
    }
  }

  command = plan

  assert {
    condition = length(keys(local.search_result)) == 3
    error_message = "Expected to return the original list if nothing matches."
  }

  assert {
    condition = length(local.search_result["123456789012"]) == 1
    error_message = "Expected entry not found or contains more entries than expected."
  }

  assert {
    condition = length(local.search_result["234567890123"]) == 1
    error_message = "Expected entry not found or contains more entries than expected."
  }

  assert {
    condition = length(local.search_result["345678901234"]) == 1
    error_message = "Expected entry not found or contains more entries than expected."
  }
}

run "filter_using_exclude.tags_-_unknown_value_doesn't_exclude_anything" {
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

    exclude = {
      tags = {
        type = [
          "unknown",
        ]
      }
    }
  }

  command = plan

  assert {
    condition = length(keys(local.search_result)) == 3
    error_message = "Expected to return the original list if nothing matches."
  }

  assert {
    condition = length(local.search_result["123456789012"]) == 1
    error_message = "Expected entry not found or contains more entries than expected."
  }

  assert {
    condition = length(local.search_result["234567890123"]) == 1
    error_message = "Expected entry not found or contains more entries than expected."
  }

  assert {
    condition = length(local.search_result["345678901234"]) == 1
    error_message = "Expected entry not found or contains more entries than expected."
  }
}

run "filter_using_exclude.tags_-_throws_exception_for_empty_map" {
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

    exclude = {
      tags = {}
    }
  }

  command = plan

  expect_failures = [
    var.exclude.tags,
  ]
}