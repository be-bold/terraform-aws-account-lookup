# Example: 'lookup-exclude-management-account'

This example will retrieve all possible outputs from the lookup module.
The organizations management account will be removed from the outputs, because `include_management_account` has been set to `false`.

## Outputs

Here are examples of what the output will look like:

### organization_id

```text
Changes to Outputs:
  + organization_id = "o-0abcd123ef"
```

### management_account_id

```text
Changes to Outputs:
  + management_account_id = "010101010101"
```

### management_account_name

```text
Changes to Outputs:
  + management_account_name = "company-name-management-account"
```

### mapping_id_to_name

```text
Changes to Outputs:
  + mapping_id_to_name = {
      + "123456789012" = "security"
      + "234567890123" = "sandbox"
      + "345678901234" = "workload"
    }
```

### mapping_name_to_id

```text
Changes to Outputs:
  + mapping_name_to_id = {
      + "security" = "123456789012"
      + "sandbox" = "234567890123"
      + "workload" = "345678901234"
    }
```

### mapping_id_to_tags

```text
Changes to Outputs:
  + mapping_id_to_tags = {
      + 123456789012 = {
          + team = "team1"
          + type = "prod"
        }
      + 234567890123 = {
          + team = "team2"
          + type = "sandbox"
        }
      + 345678901234 = {
          + team = "team2"
          + type = "nonprod"
        }
    }
```

### mapping_name_to_tags

```text
Changes to Outputs:
  + mapping_name_to_tags = {
      + security          = {
          + team = "team1"
          + type = "prod"
        }
      + sandbox           = {
          + team = "team2"
          + type = "sandbox"
        }
      + workload          = {
          + team = "team2"
          + type = "nonprod"
        }
    }
```

### account_list

```text
Changes to Outputs:
  + account_list            = {
      + "123456789012" = [
          + {
              + arn    = "arn:aws:organizations::010101010101:account/o-0abcd123ef/123456789012"
              + email  = "team1@example.org"
              + id     = "123456789012"
              + name   = "security"
              + status = "ACTIVE"
              + tags   = {
                  + team = "team1"
                  + type = "prod"
                }
            },
        ]
      + "234567890123" = [
          + {
              + arn    = "arn:aws:organizations::010101010101:account/o-0abcd123ef/234567890123"
              + email  = "team2@example.org"
              + id     = "234567890123"
              + name   = "sandbox"
              + status = "ACTIVE"
              + tags   = {
                  + team = "team2"
                  + type = "sandbox"
                }
            },
        ]
      + "345678901234" = [
          + {
              + arn    = "arn:aws:organizations::010101010101:account/o-0abcd123ef/345678901234"
              + email  = "team2@example.org"
              + id     = "345678901234"
              + name   = "workload"
              + status = "ACTIVE"
              + tags   = {
                  + team = "team2"
                  + type = "nonprod"
                }
            },
        ]
    }
```