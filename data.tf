data "aws_organizations_organization" "this" {
  provider = aws.org_management_account
}

data "aws_organizations_resource_tags" "this" {
  for_each = toset(local.all_account_ids)
  provider = aws.org_management_account
  resource_id = each.key
}