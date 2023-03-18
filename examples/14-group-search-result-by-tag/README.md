# Setup

```hcl
module "account_lookup" {
  providers = {
    aws.org_root_account = aws.org_root_account
  }
  group_by = "type"
}

output "output" {
  value = module.account_lookup.search_result
}
```

# Output

```json
Changes to Outputs:
    + output = {
        + management = [
            + {
                + account_id   = "000000000000"
                + account_name = "management-account"
                + tag1         = "value1"
                + tag2         = "value2"
                + type         = "management"
            },
        ]
        + development = [
            + {
                + account_id   = "111111111111"
                + account_name = "member-account-1-name"
                + tag1         = "value1"
                + tag2         = "value2"
                + type         = "development"
            },
            + {
                + account_id   = "333333333333"
                + account_name = "member-account-3-name"
                + tag1         = "value1"
                + tag2         = "value2"
                + type         = "development"
            },
        ]
        + production = [
            + {
                + account_id   = "222222222222"
                + account_name = "member-account-2-name"
                + tag1         = "value1"
                + tag2         = "value2"
                + type         = "production"
            },
        ]
  }
```