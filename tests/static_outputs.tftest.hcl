mock_provider "aws" {
  override_during = plan

  mock_data "aws_organizations_organization" {
    defaults = {
      id = "o-0abcd123ef"
      master_account_id = "010101010101"
      non_master_accounts = [
        {
          arn    = "arn:aws:organizations::010101010101:account/o-0abcd123ef/123456789012"
          email  = "team1@example.org"
          id     = "123456789012"
          name   = "security"
          status = "ACTIVE"
          state  = "ACTIVE"
        },
        {
          arn    = "arn:aws:organizations::010101010101:account/o-0abcd123ef/234567890123"
          email  = "team2@example.org"
          id     = "234567890123"
          name   = "sandbox"
          status = "ACTIVE"
          state  = "ACTIVE"
        },
        {
          arn    = "arn:aws:organizations::010101010101:account/o-0abcd123ef/345678901234"
          email  = "team2@example.org"
          id     = "345678901234"
          name   = "workload"
          status = "ACTIVE"
          state  = "ACTIVE"
        },
      ]
      accounts = [
        {
          arn    = "arn:aws:organizations::010101010101:account/o-0abcd123ef/010101010101"
          email  = "management@example.org"
          id     = "010101010101"
          name   = "company-name-management-account"
          status = "ACTIVE"
          state  = "ACTIVE"
        },
        {
          arn    = "arn:aws:organizations::010101010101:account/o-0abcd123ef/123456789012"
          email  = "team1@example.org"
          id     = "123456789012"
          name   = "security"
          status = "ACTIVE"
          state  = "ACTIVE"
        },
        {
          arn    = "arn:aws:organizations::010101010101:account/o-0abcd123ef/234567890123"
          email  = "team2@example.org"
          id     = "234567890123"
          name   = "sandbox"
          status = "ACTIVE"
          state  = "ACTIVE"
        },
        {
          arn    = "arn:aws:organizations::010101010101:account/o-0abcd123ef/345678901234"
          email  = "team2@example.org"
          id     = "345678901234"
          name   = "workload"
          status = "ACTIVE"
          state  = "ACTIVE"
        },
      ]
    }
  }

  mock_data "aws_organizations_resource_tags" {
    defaults = {
      tags = {}
    }
  }

  override_data {
    override_during = plan
    target = data.aws_organizations_resource_tags.this["010101010101"]
    values = {
      tags = {
        team = "team1"
        type = "prod"
      }
    }
  }

  override_data {
    override_during = plan
    target = data.aws_organizations_resource_tags.this["123456789012"]
    values = {
      tags = {
        team = "team1"
        type = "prod"
      }
    }
  }

  override_data {
    override_during = plan
    target = data.aws_organizations_resource_tags.this["234567890123"]
    values = {
      tags = {
        team = "team2"
        type = "sandbox"
      }
    }
  }

  override_data {
    override_during = plan
    target = data.aws_organizations_resource_tags.this["345678901234"]
    values = {
      tags = {
        team = "team2"
        type = "nonprod"
      }
    }
  }
}

run "correctly_returns_organization_id" {
  command = plan

  assert {
    condition     = output.organization_id == "o-0abcd123ef"
    error_message = "Organization id isn't correct."
  }
}

run "correctly_returns_management_account_id" {
  command = plan

  assert {
    condition     = output.management_account_id == "010101010101"
    error_message = "Management account id isn't correct."
  }
}

run "correctly_returns_management_account_name" {
  command = plan

  assert {
    condition     = output.management_account_name == "company-name-management-account"
    error_message = "Management account name isn't correct."
  }
}

run "correctly_returns__mapping_id_to_name__-_including_management_account" {
  command = plan

  assert {
    condition     = output.mapping_id_to_name == {
      "010101010101" = "company-name-management-account"
      123456789012 = "security"
      234567890123 = "sandbox"
      345678901234 = "workload"
    }
    error_message = "Mapping id to name including management account isn't correct."
  }
}

run "correctly_returns__mapping_id_to_name__-_excluding_management_account" {
  variables {
    include_management_account = false
  }

  command = plan

  assert {
    condition     = output.mapping_id_to_name == {
      123456789012 = "security"
      234567890123 = "sandbox"
      345678901234 = "workload"
    }
    error_message = "Mapping id to name excluding management account isn't correct."
  }
}

run "correctly_returns__mapping_name_to_id__-_including_management_account" {
  command = plan

  assert {
    condition     = output.mapping_name_to_id == {
      company-name-management-account = "010101010101"
      security = "123456789012"
      sandbox = "234567890123"
      workload = "345678901234"
    }
    error_message = "Mapping name to id including management account isn't correct."
  }
}

run "correctly_returns__mapping_name_to_id__-_excluding_management_account" {
  variables {
    include_management_account = false
  }

  command = plan

  assert {
    condition     = output.mapping_name_to_id == {
      security = "123456789012"
      sandbox = "234567890123"
      workload = "345678901234"
    }
    error_message = "Mapping name to id excluding management account isn't correct."
  }
}

run "correctly_returns__mapping_id_to_tags__-_including_management_account" {
  command = plan

  assert {
    condition     = jsonencode(output.mapping_id_to_tags) == jsonencode({
      "010101010101" = {
        team = "team1"
        type = "prod"
      }
      123456789012 = {
        team = "team1"
        type = "prod"
      }
      234567890123 = {
        team = "team2"
        type = "sandbox"
      }
      345678901234 = {
        team = "team2"
        type = "nonprod"
      }
    })
    error_message = "Mapping id to tags including management account isn't correct."
  }
}

run "correctly_returns__mapping_id_to_tags__-_excluding_management_account" {
  variables {
    include_management_account = false
  }

  command = plan

  assert {
    condition     = jsonencode(output.mapping_id_to_tags) == jsonencode({
      123456789012 = {
        team = "team1"
        type = "prod"
      }
      234567890123 = {
        team = "team2"
        type = "sandbox"
      }
      345678901234 = {
        team = "team2"
        type = "nonprod"
      }
    })
    error_message = "Mapping id to tags including management account isn't correct."
  }
}

run "correctly_returns__mapping_name_to_tags__-_including_management_account" {
  command = plan

  assert {
    condition     = jsonencode(output.mapping_name_to_tags) == jsonencode({
      company-name-management-account = {
        team = "team1"
        type = "prod"
      }
      security = {
        team = "team1"
        type = "prod"
      }
      sandbox = {
        team = "team2"
        type = "sandbox"
      }
      workload = {
        team = "team2"
        type = "nonprod"
      }
    })
    error_message = "Mapping name to tags including management account isn't correct."
  }
}

run "correctly_returns__mapping_name_to_tags__-_excluding_management_account" {
  variables {
    include_management_account = false
  }

  command = plan

  assert {
    condition     = jsonencode(output.mapping_name_to_tags) == jsonencode({
      security = {
        team = "team1"
        type = "prod"
      }
      sandbox = {
        team = "team2"
        type = "sandbox"
      }
      workload = {
        team = "team2"
        type = "nonprod"
      }
    })
    error_message = "Mapping name to tags including management account isn't correct."
  }
}

run "correctly_returns__account_list__-_including_management_account" {
  command = plan

  assert {
    condition = length(output.account_list) == 4
    error_message = "Unexpected number of entries."
  }

  assert {
    condition  = jsonencode(output.account_list) == jsonencode([
      {
        arn    = "arn:aws:organizations::010101010101:account/o-0abcd123ef/010101010101"
        email  = "management@example.org"
        id     = "010101010101"
        name   = "company-name-management-account"
        status = "ACTIVE"
        state  = "ACTIVE"
        tags = {
          team = "team1"
          type = "prod"
        }
      },
      {
        arn    = "arn:aws:organizations::010101010101:account/o-0abcd123ef/123456789012"
        email  = "team1@example.org"
        id     = "123456789012"
        name   = "security"
        status = "ACTIVE"
        state  = "ACTIVE"
        tags = {
          team = "team1"
          type = "prod"
        }
      },
      {
        arn    = "arn:aws:organizations::010101010101:account/o-0abcd123ef/234567890123"
        email  = "team2@example.org"
        id     = "234567890123"
        name   = "sandbox"
        status = "ACTIVE"
        state  = "ACTIVE"
        tags = {
          team = "team2"
          type = "sandbox"
        }
      },
      {
        arn    = "arn:aws:organizations::010101010101:account/o-0abcd123ef/345678901234"
        email  = "team2@example.org"
        id     = "345678901234"
        name   = "workload"
        status = "ACTIVE"
        state  = "ACTIVE"
        tags = {
          team = "team2"
          type = "nonprod"
        }
      },
    ])
    error_message = "Account list including the management account didn't return the expected result."
  }
}

run "correctly_returns__account_list__-_excluding_management_account" {
  variables {
    include_management_account = false
  }

  command = plan

  assert {
    condition = length(output.account_list) == 3
    error_message = "Unexpected number of entries."
  }

  assert {
    condition  = jsonencode(output.account_list) == jsonencode([
      {
        arn    = "arn:aws:organizations::010101010101:account/o-0abcd123ef/123456789012"
        email  = "team1@example.org"
        id     = "123456789012"
        name   = "security"
        status = "ACTIVE"
        state  = "ACTIVE"
        tags = {
          team = "team1"
          type = "prod"
        }
      },
      {
        arn    = "arn:aws:organizations::010101010101:account/o-0abcd123ef/234567890123"
        email  = "team2@example.org"
        id     = "234567890123"
        name   = "sandbox"
        status = "ACTIVE"
        state  = "ACTIVE"
        tags = {
          team = "team2"
          type = "sandbox"
        }
      },
      {
        arn    = "arn:aws:organizations::010101010101:account/o-0abcd123ef/345678901234"
        email  = "team2@example.org"
        id     = "345678901234"
        name   = "workload"
        status = "ACTIVE"
        state  = "ACTIVE"
        tags = {
          team = "team2"
          type = "nonprod"
        }
      },
    ])
    error_message = "Account list excluding the management account didn't return the expected result."
  }
}