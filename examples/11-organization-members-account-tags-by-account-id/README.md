# Setup
```hcl
module "account_lookup" {
  providers = {
    aws.org_root_account = aws.org_root_account
  }
}

output "output" {
  value = module.account_lookup.organization_members_account_tags_by_account_id
}
```

# Output
```json
Changes to Outputs:
    + output = {
        + "111111111111" = {
            + tag1 = "value1"
            + tag2 = "value2"
            + tag3 = "value3"
        }
        + "222222222222" = {
            + tag1 = "value1"
            + tag2 = "value2"
            + tag3 = "value3"
        }
        + "333333333333" = {
            + tag1 = "value1"
            + tag2 = "value2"
            + tag3 = "value3"
        }
    }
```