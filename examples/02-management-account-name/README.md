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
  value = module.account_lookup.management_account_name
}
```

# Output

```json
Changes to Outputs:
  + output = "management-account"
```
