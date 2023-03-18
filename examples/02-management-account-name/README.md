# Setup

```hcl
module "account_lookup" {
  providers = {
    aws.org_root_account = aws.org_root_account
  }
}

output "output" {
  value = module.account_lookup.management_account_name
}
```

# Output

```json
Changes to Outputs:
  + output = "my-management-account-name"
```