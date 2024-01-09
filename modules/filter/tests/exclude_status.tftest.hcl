run "filter_using_exclude.status_-_successfully_filter_for_single_entry_with_assertions_on_all_properties" {
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
        status = "SUSPENDED"
        tags   = {
          type = "nonprod"
        }
      },
      {
        id     = "345678901234"
        arn    = "arn:aws:organizations::000000000001:account/o-0abcd123ef/345678901234"
        name   = "account03"
        email  = "account03@example.org"
        status = "PENDING_CLOSURE"
        tags   = {
          type = "prod"
        }
      },
    ]

    # override the default
    include = {
      status = [
        "ACTIVE",
        "SUSPENDED",
        "PENDING_CLOSURE",
      ]
    }

    exclude = {
      status = [
        "ACTIVE",
        "PENDING_CLOSURE",
      ]
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
    condition = local.search_result["234567890123"][0]["status"] == "SUSPENDED"
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

run "filter_using_exclude.status_-_successfully_filter_for_multiple_entries" {
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
        status = "SUSPENDED"
        tags   = {
          type = "nonprod"
        }
      },
      {
        id     = "345678901234"
        arn    = "arn:aws:organizations::000000000001:account/o-0abcd123ef/345678901234"
        name   = "account03"
        email  = "account03@example.org"
        status = "PENDING_CLOSURE"
        tags   = {
          type = "prod"
        }
      },
    ]

    # override the default
    include = {
      status = [
        "ACTIVE",
        "SUSPENDED",
        "PENDING_CLOSURE",
      ]
    }

    exclude = {
      status = [
        "SUSPENDED",
      ]
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

run "filter_using_exclude.status_-_only_return_known_entry_if_you_filter_for_known_and_unknown_entry" {
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
        status = "SUSPENDED"
        tags   = {
          type = "nonprod"
        }
      },
      {
        id     = "345678901234"
        arn    = "arn:aws:organizations::000000000001:account/o-0abcd123ef/345678901234"
        name   = "account03"
        email  = "account03@example.org"
        status = "SUSPENDED"
        tags   = {
          type = "prod"
        }
      },
    ]

    # override the default
    include = {
      status = [
        "ACTIVE",
        "SUSPENDED",
        "PENDING_CLOSURE",
      ]
    }

    exclude = {
      status = [
        "ACTIVE",
        "PENDING_CLOSURE",
      ]
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
    condition = length(local.search_result["345678901234"]) == 1
    error_message = "Expected entry not found or contains more entries than expected."
  }
}

run "filter_using_exclude.status_-_unknown_entry_doesn't_exclude_anything" {
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
        status = "SUSPENDED"
        tags   = {
          type = "nonprod"
        }
      },
      {
        id     = "345678901234"
        arn    = "arn:aws:organizations::000000000001:account/o-0abcd123ef/345678901234"
        name   = "account03"
        email  = "account03@example.org"
        status = "SUSPENDED"
        tags   = {
          type = "prod"
        }
      },
    ]

    # override the default
    include = {
      status = [
        "ACTIVE",
        "SUSPENDED",
        "PENDING_CLOSURE",
      ]
    }

    exclude = {
      status = [
        "PENDING_CLOSURE",
      ]
    }
  }

  command = plan

  assert {
    condition = length(keys(local.search_result)) == 3
    error_message = "Expected 2 entries in search result."
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