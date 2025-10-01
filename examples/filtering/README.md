# Example: 'filtering'

This example will retrieve the list of accounts using the lookup module and passes them to the filter
module where several filter steps are being performed.

## Outputs

Here is an example of what the output will look like:

### result

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
              + state  = "ACTIVE"
              + tags   = {
                  + team = "team1"
                  + type = "prod"
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
              + state  = "ACTIVE"
              + tags   = {
                  + team = "team2"
                  + type = "nonprod"
                }
            },
        ]
    }
```