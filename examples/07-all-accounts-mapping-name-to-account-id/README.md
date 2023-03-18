# Setup
```hcl
module "account_lookup" {
  providers = {
    aws.org_root_account = aws.org_root_account
  }
}

output "output" {
  value = module.account_lookup.all_accounts_mapping_name_to_account_id
}
```

# Output
```json
Changes to Outputs:
    + output = {
        + management-account    = "000000000000"
        + member-account-1-name = "111111111111"
        + member-account-2-name = "222222222222"
        + member-account-3-name = "333333333333"
    }
```