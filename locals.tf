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

  # Search
  search_base = [
    for account_id in local.all_account_ids : merge({
      account_id = account_id
      account_name = local.all_accounts_mapping_account_id_to_name[account_id]
    }, local.all_accounts_tags_by_account_id[account_id])
  ]

  search_step1_include_or_exclude_management_account = [
    for entry in local.search_base : entry if entry["account_id"] != local.management_account_id || var.include_management_account
  ]


  include_filter_flattened = [
    for key, value in var.include : "${key}-${value}"
  ]

  search_step2_include_filter = length(var.include) > 0 ? [
    for entry in local.search_step1_include_or_exclude_management_account : entry if length(setsubtract(local.include_filter_flattened, [for key, value in entry : "${key}-${value}"])) == 0
  ] : local.search_step1_include_or_exclude_management_account


  exclude_filter_flattened = [
    for key, value in var.exclude : "${key}-${value}"
  ]

  search_step3_exclude_filter = length(var.exclude) > 0 ? [
    for entry in local.search_step2_include_filter : entry if length(setsubtract(local.exclude_filter_flattened, [for key, value in entry : "${key}-${value}"])) != 0
  ] : local.search_step2_include_filter


  search_result_group_id_missing_key = "group_id_missing"

  search_step4_grouping = {
    for entry in local.search_step3_exclude_filter :
      lookup(entry, var.group_by, local.search_result_group_id_missing_key) => entry...
  }

  search_result = local.search_step4_grouping
}