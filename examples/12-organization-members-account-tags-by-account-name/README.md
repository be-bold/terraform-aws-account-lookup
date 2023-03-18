# Setup

```hcl
module "account_lookup" {
  providers = {
    aws.org_management_account = aws.org_management_account
  }
}

output "output" {
  value = module.account_lookup.organization_members_account_tags_by_account_name
}
```

# Output

```json
Changes to Outputs:
    + output = {
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