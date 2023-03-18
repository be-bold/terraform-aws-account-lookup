# Setup
```hcl
module "account_lookup" {
  providers = {
    aws.org_root_account = aws.org_root_account
  }
}

output "output" {
  value = module.account_lookup.organization_members_mapping_account_id_to_name
}
```

# Output
```json
Changes to Outputs:
    + output = {
        + "111111111111" = "member-account-1-name" 
        + "222222222222" = "member-account-2-name" 
        + "333333333333" = "member-account-3-name" 
    }
```