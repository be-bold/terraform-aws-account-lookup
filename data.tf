data "aws_organizations_organization" "this" {}

data "aws_organizations_resource_tags" "this" {
  for_each = toset(local.all_account_ids)
  resource_id = each.key
}