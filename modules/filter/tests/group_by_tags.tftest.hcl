run "group_by_tag_-_every_entry_provides_given_tag" {
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
          team = "team1"
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
          type = "prod"
          team = "team1"
        }
      },
    ]

    group_by_tag = "team"
  }

  command = plan

  assert {
    condition     = length(keys(local.search_result)) == 2
    error_message = "Expected 2 entries in search result."
  }

  assert {
    condition     = length(local.search_result["team1"]) == 2
    error_message = "Expected entry not found or contains more entries than expected."
  }

  assert {
    condition     = local.search_result["team1"][0]["id"] == "123456789012"
    error_message = "Expected entry not found."
  }

  assert {
    condition     = local.search_result["team1"][1]["id"] == "345678901234"
    error_message = "Expected entry not found."
  }

  assert {
    condition     = length(local.search_result["team2"]) == 1
    error_message = "Expected entry not found or contains more entries than expected."
  }

  assert {
    condition     = local.search_result["team2"][0]["id"] == "234567890123"
    error_message = "Expected entry not found."
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
        status = "ACTIVE"
        tags   = {
          type = "sandbox"
          team = "team1"
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
          team = "team2"
          my_tag  = "this"
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
          team = "team1"
          my_tag  = "other"
        }
      },
      {
        id     = "456789012345"
        arn    = "arn:aws:organizations::000000000001:account/o-0abcd123ef/456789012345"
        name   = "account04"
        email  = "account04@example.org"
        status = "ACTIVE"
        tags   = {
          type = "prod"
          team = "team3"
        }
      },
      {
        id     = "567890123456"
        arn    = "arn:aws:organizations::000000000001:account/o-0abcd123ef/567890123456"
        name   = "account05"
        email  = "account05@example.org"
        status = "ACTIVE"
        tags   = {
          type = "nonprod"
          team = "team3"
          my_tag  = "other"
        }
      },
    ]

    group_by_tag = "my_tag"
  }

  command = plan

  assert {
    condition     = length(keys(local.search_result)) == 3
    error_message = "Expected 3 entries in search result."
  }

  assert {
    condition     = length(local.search_result["this"]) == 1
    error_message = "Expected entry not found or contains more entries than expected."
  }

  assert {
    condition     = local.search_result["this"][0]["id"] == "234567890123"
    error_message = "Expected entry not found."
  }

  assert {
    condition     = length(local.search_result["other"]) == 2
    error_message = "Expected entry not found or contains more entries than expected."
  }

  assert {
    condition     = local.search_result["other"][0]["id"] == "345678901234"
    error_message = "Expected entry not found."
  }

  assert {
    condition     = local.search_result["other"][1]["id"] == "567890123456"
    error_message = "Expected entry not found."
  }

  assert {
    condition     = length(local.search_result["group_id_missing"]) == 2
    error_message = "Expected entry not found or contains more entries than expected."
  }

  assert {
    condition     = local.search_result["group_id_missing"][0]["id"] == "123456789012"
    error_message = "Expected entry not found."
  }

  assert {
    condition     = local.search_result["group_id_missing"][1]["id"] == "456789012345"
    error_message = "Expected entry not found."
  }
}