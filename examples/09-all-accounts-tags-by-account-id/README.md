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
  value = module.account_lookup.all_accounts_tags_by_account_id
}
```

# Output

```json
Changes to Outputs:
    + output = {
        + "000000000000" = {
            + tag1 = "value1"
            + tag2 = "value2"
            + type = "management"
        }
        + "111111111111" = {
            + tag1 = "value1"
            + tag2 = "value2"
            + type = "development"
        }
        + "222222222222" = {
            + tag1 = "value1"
            + tag2 = "value2"
            + type = "production"
        }
        + "333333333333" = {
            + tag1 = "value1"
            + tag2 = "value2"
            + type = "development"
        }
    }
```