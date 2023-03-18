# Setup

```hcl
module "account_lookup" {
  providers = {
    aws.org_root_account = aws.org_root_account
  }
  include_management_account = false
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
        + "222222222222" = [
            + {
                + account_id   = "222222222222"
                + account_name = "member-account-2-name"
                + tag1         = "value1"
                + tag2         = "value2"
                + type         = "production"
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