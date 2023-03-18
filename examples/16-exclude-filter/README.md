# Setup

```hcl
module "account_lookup" {
  providers = {
    aws.org_management_account = aws.org_management_account
  }
  exclude = {
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
        + "000000000000" = [
            + {
                + account_id   = "000000000000"
                + account_name = "management-account"
                + tag1         = "value1"
                + tag2         = "value2"
                + type         = "management"
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
  }
```