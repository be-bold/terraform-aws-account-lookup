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
  value = module.account_lookup.all_account_ids
}
```

# Output

```json
Changes to Outputs:
    + output = [
        + "000000000000",
        + "111111111111",
        + "222222222222",
        + "333333333333",
    ]
```
