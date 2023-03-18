# Setup

```hcl
module "account_lookup" {
  providers = {
    aws.org_management_account = aws.org_management_account
  }
  include = {
    type = "development"
  }
}

output "output" {
  value = module.account_lookup.search_result
}
```

# Output

```json
Changes to Outputs:
    + output = {
        + "111111111111" = [
            + {
                + account_id   = "111111111111"
                + account_name = "member-account-1-name"
                + tag1         = "value1"
                + tag2         = "value2"
                + type         = "development"
            },
        ]
        + "333333333333" = [
            + {
                + account_id   = "333333333333"
                + account_name = "member-account-3-name"
                + tag1         = "value1"
                + tag2         = "value2"
                + type         = "development"
            },
        ]
  }
```