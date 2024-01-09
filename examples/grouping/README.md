# Example: 'grouping'

This example will retrieve the list of accounts using the lookup module and passes them to the filter
module where the entries are grouped by the tag `team`.

## Outputs

Here is an example of what the output will look like:

### result

```text
Changes to Outputs:
  + account_list            = {
      + "team1" = [
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
      + "team2" = [
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