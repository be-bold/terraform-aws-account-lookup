# Setup
```hcl
module "account_lookup" {
  providers = {
    aws.org_root_account = aws.org_root_account
  }
}

output "output" {
  value = module.account_lookup.management_account_id
}
```

# Output
```json
Changes to Outputs:
  + output = "000000000000"
```