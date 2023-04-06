# Setup

```hcl
module "account_lookup" {
  source    = "be-bold/account-lookup/aws"
  version   = "#.#.#"
  
  providers = {
    aws.org_management_account = aws.org_management_account
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
            + type = "management"
        }
        + member-account-1-name = {
            + tag1 = "value1"
            + tag2 = "value2"
            + type = "development"
        }
        + member-account-2-name = {
            + tag1 = "value1"
            + tag2 = "value2"
            + type = "production"
        }
        + member-account-3-name = {
            + tag1 = "value1"
            + tag2 = "value2"
            + type = "development"
        }
    }
```
