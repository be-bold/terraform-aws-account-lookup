# Setup
```hcl
module "account_lookup" {
  providers = {
    aws.org_root_account = aws.org_root_account
  }
}

output "output" {
  value = module.account_lookup.all_accounts_tags_by_account_name
}
```

# Output
```json
Changes to Outputs:
    + output = {
        + management-account = {
            + tag1 = "value1"
            + tag2 = "value2"
            + tag3 = "value3"
        }
        + member-account-1-name = {
            + tag1 = "value1"
            + tag2 = "value2"
            + tag3 = "value3"
        }
        + member-account-2-name = {
            + tag1 = "value1"
            + tag2 = "value2"
            + tag3 = "value3"
        }
        + member-account-3-name = {
            + tag1 = "value1"
            + tag2 = "value2"
            + tag3 = "value3"
        }
    }
```