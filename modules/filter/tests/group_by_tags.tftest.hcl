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

    group_by_tag = "team"
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

run "group_by_tag_-_entries_not_providing_tag_are_listed_with_a_special_index" {
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

    group_by_tag = "my_tag"
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
      group_id_missing = [
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