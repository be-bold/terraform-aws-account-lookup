locals {
  # Management account
  management_account_id = data.aws_organizations_organization.this.master_account_id
  management_account_name = lower({
    for account in data.aws_organizations_organization.this.accounts : "result" => account["name"] if account["id"] == local.management_account_id
  }["result"])

  # Lists of account ids
  member_account_ids = data.aws_organizations_organization.this.non_master_accounts.*.id

  all_account_ids = data.aws_organizations_organization.this.accounts.*.id


  # Mapping between account id and name
  organization_members_mapping_name_to_account_id = {
    for account in data.aws_organizations_organization.this.non_master_accounts : account.name => account.id
  }

  organization_members_mapping_account_id_to_name = {
    for account in data.aws_organizations_organization.this.non_master_accounts : account.id => account.name
  }


  all_accounts_mapping_name_to_account_id = merge(local.organization_members_mapping_name_to_account_id, {
    (local.management_account_name) = local.management_account_id
  })

  all_accounts_mapping_account_id_to_name = merge(local.organization_members_mapping_account_id_to_name, {
    (local.management_account_id) = local.management_account_name
  })


  # Tagging
  all_accounts_tags_by_account_id = {
    for account_id in local.all_account_ids : account_id => data.aws_organizations_resource_tags.this[account_id].tags
  }

  all_accounts_tags_by_account_name = {
    for account_id in local.all_account_ids : local.all_accounts_mapping_account_id_to_name[account_id] => data.aws_organizations_resource_tags.this[account_id].tags
  }


  organization_members_account_tags_by_account_id = {
    for account_id in local.all_account_ids : account_id => data.aws_organizations_resource_tags.this[account_id].tags if account_id != local.management_account_id
  }

  organization_members_account_tags_by_account_name = {
    for account_id in local.all_account_ids : local.all_accounts_mapping_account_id_to_name[account_id] => data.aws_organizations_resource_tags.this[account_id].tags if account_id != local.management_account_id
  }
}