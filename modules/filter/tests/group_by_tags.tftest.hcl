run "group_by_tag_-_throws_exception_if_tag_is_null" {
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
          team = "team1"
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
          team = "team2"
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
          team = "team1"
        }
        joined = {
          method    = "CREATED"
          timestamp = "2025-01-03T14:03:56.054000+01:00"
        }
      },
    ]

    group_by_tag = {
      tag = null
    }
  }

  command = plan

  expect_failures = [
    var.group_by_tag.tag
  ]
}

run "group_by_tag_-_throws_exception_if_tag_is_empty" {
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
          team = "team1"
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
          team = "team2"
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
          team = "team1"
        }
        joined = {
          method    = "CREATED"
          timestamp = "2025-01-03T14:03:56.054000+01:00"
        }
      },
    ]

    group_by_tag = {
      tag = ""
    }
  }

  command = plan

  expect_failures = [
    var.group_by_tag.tag
  ]
}


run "group_by_tag_-_default_value_for_include_ungrouped_accounts_is_true" {
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
          team = "team1"
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
          team = "team2"
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
          team = "team1"
        }
        joined = {
          method    = "CREATED"
          timestamp = "2025-01-03T14:03:56.054000+01:00"
        }
      },
    ]

    group_by_tag = {
      tag = "test"
    }
  }

  command = plan

  assert {
    condition = local.is_include_ungrouped_accounts
    error_message = "Expecting default value of is_include_ungrouped_accounts to be true."
  }
}

run "group_by_tag_-_correctly_set_to_false_based_on_input" {
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
          team = "team1"
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
          team = "team2"
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
          team = "team1"
        }
        joined = {
          method    = "CREATED"
          timestamp = "2025-01-03T14:03:56.054000+01:00"
        }
      },
    ]

    group_by_tag = {
      tag = "test"
      include_ungrouped_accounts = false
    }
  }

  command = plan

  assert {
    condition = !local.is_include_ungrouped_accounts
    error_message = "Expecting users to be able to set is_include_ungrouped_accounts to false."
  }
}


run "group_by_tag_-_on_null_default_value_for_ungrouped_key_is_tag_missing" {
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
          team = "team1"
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
          team = "team2"
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
          team = "team1"
        }
        joined = {
          method    = "CREATED"
          timestamp = "2025-01-03T14:03:56.054000+01:00"
        }
      },
    ]

    group_by_tag = {
      tag = "test"
    }
  }

  command = plan

  assert {
    condition = local.ungrouped_key == "tag_missing"
    error_message = "Expecting default value of ungrouped_key to be 'tag_missing'."
  }
}

run "group_by_tag_-_on_empty_string_default_value_for_ungrouped_key_is_tag_missing" {
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
          team = "team1"
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
          team = "team2"
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
          team = "team1"
        }
        joined = {
          method    = "CREATED"
          timestamp = "2025-01-03T14:03:56.054000+01:00"
        }
      },
    ]

    group_by_tag = {
      tag = "test"
      ungrouped_key = ""
    }
  }

  command = plan

  assert {
    condition = local.ungrouped_key == "tag_missing"
    error_message = "Expecting default value of ungrouped_key to be 'tag_missing'."
  }
}

run "group_by_tag_-_ungrouped_key_is_timmed" {
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
          team = "team1"
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
          team = "team2"
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
          team = "team1"
        }
        joined = {
          method    = "CREATED"
          timestamp = "2025-01-03T14:03:56.054000+01:00"
        }
      },
    ]

    group_by_tag = {
      tag = "test"
      ungrouped_key = "   my-key   "
    }
  }

  command = plan

  assert {
    condition = local.ungrouped_key == "my-key"
    error_message = "Expecting the user input to be trimmed."
  }
}


run "group_by_tag_-_every_entry_provides_given_tag" {
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
          team = "team1"
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
          team = "team2"
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
          team = "team1"
        }
        joined = {
          method    = "CREATED"
          timestamp = "2025-01-03T14:03:56.054000+01:00"
        }
      },
    ]

    group_by_tag = {
      tag = "team"
    }
  }

  command = plan

  assert {
    condition = jsonencode(output.result) == jsonencode({
      team1 = [
        {
          id     = "123456789012"
          arn    = "arn:aws:organizations::000000000001:account/o-0abcd123ef/123456789012"
          name   = "account01"
          email  = "account01@example.org"
            state  = "ACTIVE"
          tags   = {
            type = "sandbox"
            team = "team1"
          }
          joined = {
            method    = "CREATED"
            timestamp = "2025-01-01T14:03:56.054000+01:00"
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
            team = "team1"
          }
          joined = {
            method    = "CREATED"
            timestamp = "2025-01-03T14:03:56.054000+01:00"
          }
        },
      ]
      team2 = [
        {
          id     = "234567890123"
          arn    = "arn:aws:organizations::000000000001:account/o-0abcd123ef/234567890123"
          name   = "account02"
          email  = "account02@example.org"
            state  = "ACTIVE"
          tags   = {
            type = "nonprod"
            team = "team2"
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

run "group_by_tag_-_entries_not_providing_tag_are_listed_with_the_default_key_for_ungrouped_accounts" {
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
          team = "team1"
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
          team = "team2"
          my_tag  = "this"
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
          team = "team1"
          my_tag  = "other"
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
        state  = "ACTIVE"
        tags   = {
          type = "prod"
          team = "team3"
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
        state  = "ACTIVE"
        tags   = {
          type = "nonprod"
          team = "team3"
          my_tag  = "other"
        }
        joined = {
          method    = "CREATED"
          timestamp = "2025-01-05T14:03:56.054000+01:00"
        }
      },
    ]

    group_by_tag = {
      tag = "my_tag"
    }
  }

  command = plan

  assert {
    condition = jsonencode(output.result) == jsonencode({
      this = [
        {
          id     = "234567890123"
          arn    = "arn:aws:organizations::000000000001:account/o-0abcd123ef/234567890123"
          name   = "account02"
          email  = "account02@example.org"
            state  = "ACTIVE"
          tags   = {
            type = "nonprod"
            team = "team2"
            my_tag  = "this"
          }
          joined = {
            method    = "CREATED"
            timestamp = "2025-01-02T14:03:56.054000+01:00"
          }
        },
      ]
      other = [
        {
          id     = "345678901234"
          arn    = "arn:aws:organizations::000000000001:account/o-0abcd123ef/345678901234"
          name   = "account03"
          email  = "account03@example.org"
            state  = "ACTIVE"
          tags   = {
            type = "prod"
            team = "team1"
            my_tag  = "other"
          }
          joined = {
            method    = "CREATED"
            timestamp = "2025-01-03T14:03:56.054000+01:00"
          }
        },
        {
          id     = "567890123456"
          arn    = "arn:aws:organizations::000000000001:account/o-0abcd123ef/567890123456"
          name   = "account05"
          email  = "account05@example.org"
            state  = "ACTIVE"
          tags   = {
            type = "nonprod"
            team = "team3"
            my_tag  = "other"
          }
          joined = {
            method    = "CREATED"
            timestamp = "2025-01-05T14:03:56.054000+01:00"
          }
        },
      ]
      tag_missing = [
        {
          id     = "123456789012"
          arn    = "arn:aws:organizations::000000000001:account/o-0abcd123ef/123456789012"
          name   = "account01"
          email  = "account01@example.org"
            state  = "ACTIVE"
          tags   = {
            type = "sandbox"
            team = "team1"
          }
          joined = {
            method    = "CREATED"
            timestamp = "2025-01-01T14:03:56.054000+01:00"
          }
        },
        {
          id     = "456789012345"
          arn    = "arn:aws:organizations::000000000001:account/o-0abcd123ef/456789012345"
          name   = "account04"
          email  = "account04@example.org"
            state  = "ACTIVE"
          tags   = {
            type = "prod"
            team = "team3"
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

run "group_by_tag_-_entries_not_providing_tag_are_listed_with_the_custom_key_for_ungrouped_accounts" {
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
          team = "team1"
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
          team = "team2"
          my_tag  = "this"
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
          team = "team1"
          my_tag  = "other"
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
        state  = "ACTIVE"
        tags   = {
          type = "prod"
          team = "team3"
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
        state  = "ACTIVE"
        tags   = {
          type = "nonprod"
          team = "team3"
          my_tag  = "other"
        }
        joined = {
          method    = "CREATED"
          timestamp = "2025-01-05T14:03:56.054000+01:00"
        }
      },
    ]

    group_by_tag = {
      tag = "my_tag"
      ungrouped_key = "custom-group"
    }
  }

  command = plan

  assert {
    condition = jsonencode(output.result) == jsonencode({
      this = [
        {
          id     = "234567890123"
          arn    = "arn:aws:organizations::000000000001:account/o-0abcd123ef/234567890123"
          name   = "account02"
          email  = "account02@example.org"
          state  = "ACTIVE"
          tags   = {
            type = "nonprod"
            team = "team2"
            my_tag  = "this"
          }
          joined = {
            method    = "CREATED"
            timestamp = "2025-01-02T14:03:56.054000+01:00"
          }
        },
      ]
      other = [
        {
          id     = "345678901234"
          arn    = "arn:aws:organizations::000000000001:account/o-0abcd123ef/345678901234"
          name   = "account03"
          email  = "account03@example.org"
          state  = "ACTIVE"
          tags   = {
            type = "prod"
            team = "team1"
            my_tag  = "other"
          }
          joined = {
            method    = "CREATED"
            timestamp = "2025-01-03T14:03:56.054000+01:00"
          }
        },
        {
          id     = "567890123456"
          arn    = "arn:aws:organizations::000000000001:account/o-0abcd123ef/567890123456"
          name   = "account05"
          email  = "account05@example.org"
          state  = "ACTIVE"
          tags   = {
            type = "nonprod"
            team = "team3"
            my_tag  = "other"
          }
          joined = {
            method    = "CREATED"
            timestamp = "2025-01-05T14:03:56.054000+01:00"
          }
        },
      ]
      custom-group = [
        {
          id     = "123456789012"
          arn    = "arn:aws:organizations::000000000001:account/o-0abcd123ef/123456789012"
          name   = "account01"
          email  = "account01@example.org"
          state  = "ACTIVE"
          tags   = {
            type = "sandbox"
            team = "team1"
          }
          joined = {
            method    = "CREATED"
            timestamp = "2025-01-01T14:03:56.054000+01:00"
          }
        },
        {
          id     = "456789012345"
          arn    = "arn:aws:organizations::000000000001:account/o-0abcd123ef/456789012345"
          name   = "account04"
          email  = "account04@example.org"
          state  = "ACTIVE"
          tags   = {
            type = "prod"
            team = "team3"
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

run "group_by_tag_-_entries_not_providing_tag_are_not_part_of_the_result_set" {
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
          team = "team1"
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
          team = "team2"
          my_tag  = "this"
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
          team = "team1"
          my_tag  = "other"
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
        state  = "ACTIVE"
        tags   = {
          type = "prod"
          team = "team3"
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
        state  = "ACTIVE"
        tags   = {
          type = "nonprod"
          team = "team3"
          my_tag  = "other"
        }
        joined = {
          method    = "CREATED"
          timestamp = "2025-01-05T14:03:56.054000+01:00"
        }
      },
    ]

    group_by_tag = {
      tag = "my_tag"
      include_ungrouped_accounts = false
      ungrouped_key = "custom-group"
    }
  }

  command = plan

  assert {
    condition = jsonencode(output.result) == jsonencode({
      this = [
        {
          id     = "234567890123"
          arn    = "arn:aws:organizations::000000000001:account/o-0abcd123ef/234567890123"
          name   = "account02"
          email  = "account02@example.org"
          state  = "ACTIVE"
          tags   = {
            type = "nonprod"
            team = "team2"
            my_tag  = "this"
          }
          joined = {
            method    = "CREATED"
            timestamp = "2025-01-02T14:03:56.054000+01:00"
          }
        },
      ]
      other = [
        {
          id     = "345678901234"
          arn    = "arn:aws:organizations::000000000001:account/o-0abcd123ef/345678901234"
          name   = "account03"
          email  = "account03@example.org"
          state  = "ACTIVE"
          tags   = {
            type = "prod"
            team = "team1"
            my_tag  = "other"
          }
          joined = {
            method    = "CREATED"
            timestamp = "2025-01-03T14:03:56.054000+01:00"
          }
        },
        {
          id     = "567890123456"
          arn    = "arn:aws:organizations::000000000001:account/o-0abcd123ef/567890123456"
          name   = "account05"
          email  = "account05@example.org"
          state  = "ACTIVE"
          tags   = {
            type = "nonprod"
            team = "team3"
            my_tag  = "other"
          }
          joined = {
            method    = "CREATED"
            timestamp = "2025-01-05T14:03:56.054000+01:00"
          }
        },
      ]
    })
    error_message = "Account list doesn't contain the expected entries."
  }
}