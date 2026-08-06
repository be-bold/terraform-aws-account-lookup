locals {
  # Management account
  management_account_id = data.aws_organizations_organization.this.master_account_id
  management_account_name = lower({
    for account in data.aws_organizations_organization.this.accounts : "result" => account["name"] if account["id"] == local.management_account_id
  }["result"])

  # Lists of accounts
  all_account_ids = data.aws_organizations_organization.this.accounts.*.id
  member_accounts = data.aws_organizations_organization.this.non_master_accounts
  all_accounts = data.aws_organizations_organization.this.accounts
  selected_accounts = var.include_management_account ? local.all_accounts : local.member_accounts
  account_list = [
    for account in local.selected_accounts : {
      id = account.id
      arn = account.arn
      name = account.name
      email = account.email
      state = account.state
      joined = {
        method = account.joined_method
        timestamp = account.joined_timestamp
      }
      tags = local.mapping_id_to_tags[account.id]
    }
  ]

  # Mapping: id => name
  mapping_id_to_name = {
    for account in local.selected_accounts : account.id => account.name
  }

  # Mapping: name => id
  mapping_name_to_id = {
    for account in local.selected_accounts : account.name => account.id
  }

  # Mapping: id => tags
  mapping_id_to_tags = {
    for account in local.selected_accounts : account.id => data.aws_organizations_resource_tags.this[account.id].tags
  }

  # Mapping: name => tags
  mapping_name_to_tags = {
    for account in local.selected_accounts : account.name => data.aws_organizations_resource_tags.this[account.id].tags
  }
}