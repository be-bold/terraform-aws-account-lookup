# Setup

```hcl
module "account_lookup" {
  providers = {
    aws.org_root_account = aws.org_root_account
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