locals {
  # Search
  account_details_lookup = { for account in data.aws_organizations_organization.this.accounts : account.id => account }
  search_result_group_id_missing_key = "group_id_missing"


  ## BASE
  search_base = [
    for account_id in local.all_account_ids : {
      id = account_id
      arn = local.account_details_lookup[account_id]["arn"]
      name = local.account_details_lookup[account_id]["name"]
      email = local.account_details_lookup[account_id]["email"]
      status = local.account_details_lookup[account_id]["status"]
      tags = local.all_accounts_tags_by_account_id[account_id]
    }
  ]


  # STEP 1 - include id
  is_include_id_set = var.include != null && var.include.id != null && try(length(var.include.id) > 0, false)
  search_step1_include_id = !local.is_include_id_set ? local.search_base : [ for account in local.search_base : account if anytrue([ for value in var.include.id : true if account.id == value])  ]


  # STEP 2 - include arn
  is_include_arn_set = var.include != null && var.include.arn != null && try(length(var.include.arn) > 0, false)
  search_step2_include_arn = !local.is_include_arn_set ? local.search_step1_include_id : [ for account in local.search_step1_include_id : account if anytrue([ for value in var.include.arn : true if account.arn == value])  ]


  # STEP 3 - include email
  is_include_email_set = var.include != null && var.include.email != null && try(length(var.include.email) > 0, false)
  search_step3_include_email = !local.is_include_email_set ? local.search_step2_include_arn : [ for account in local.search_step2_include_arn : account if anytrue([ for value in var.include.email : true if account.email == value])  ]


  # STEP 4 - include status
  is_include_status_set = var.include != null && var.include.status != null && try(length(var.include.status) > 0, false)
  search_step4_include_status = !local.is_include_status_set ? local.search_step3_include_email : [ for account in local.search_step3_include_email : account if anytrue([ for value in var.include.status : true if account.status == value])  ]


  ## STEP 5 - include name
  is_include_name_set = var.include != null && var.include.name != null
  search_step5_include_name = !local.is_include_name_set ? local.search_step4_include_status : local.include_name_matcher

  include_name_matcher = !local.is_include_name_set ? [] : var.include.name.matcher == "startswith" ? local.include_name_startswith : var.include.name.matcher == "endswith" ? local.include_name_endswith : var.include.name.matcher == "equals" ? local.include_name_equals : []
  include_name_startswith = !local.is_include_name_set ? [] : [ for account in local.search_step4_include_status : account if anytrue([ for prefix in var.include.name.values : true if startswith(account.name, prefix)]) ]
  include_name_endswith = !local.is_include_name_set ? [] : [ for account in local.search_step4_include_status : account if anytrue([ for suffix in var.include.name.values : true if endswith(account.name, suffix)]) ]
  include_name_equals = !local.is_include_name_set ? [] : [ for account in local.search_step4_include_status : account if anytrue([ for value in var.include.name.values : true if account.name == value]) ]


  ## STEP 6 - include tags
  is_include_tags_set = var.include != null && var.include.tags != null && try(length(var.include.tags) > 0, false)
  search_step6_include_tags = !local.is_include_tags_set ? local.search_step5_include_name : local.include_tags_result

  include_tags_accounts_containing_all_tags_from_filter_option = !local.is_include_tags_set ? [] : [ for account in local.search_step5_include_name : account if alltrue([ for tag_name, search_strings in var.include.tags : lookup(account.tags, tag_name, null) != null ]) ]
  include_tags_result = !local.is_include_tags_set ? [] : [ for account in local.include_tags_accounts_containing_all_tags_from_filter_option : account if alltrue([ for tag_name, search_strings in var.include.tags : anytrue([ for search_string in search_strings : account.tags[tag_name] == search_string ]) ]) ]


  # STEP 7 - exclude id
  is_exclude_id_set = var.exclude != null && var.exclude.id != null && try(length(var.exclude.id) > 0, false)
  search_step7_exclude_id = !local.is_exclude_id_set ? local.search_step6_include_tags : [ for account in local.search_step6_include_tags : account if anytrue([ for value in var.exclude.id : true if account.id != value])  ]


  # STEP 8 - exclude arn
  is_exclude_arn_set = var.exclude != null && var.exclude.arn != null && try(length(var.exclude.arn) > 0, false)
  search_step8_exclude_arn = !local.is_exclude_arn_set ? local.search_step7_exclude_id : [ for account in local.search_step7_exclude_id : account if anytrue([ for value in var.exclude.arn : true if account.arn != value])  ]


  # STEP 9 - exclude email
  is_exclude_email_set = var.exclude != null && var.exclude.email != null && try(length(var.exclude.email) > 0, false)
  search_step9_exclude_email = !local.is_exclude_email_set ? local.search_step8_exclude_arn : [ for account in local.search_step8_exclude_arn : account if anytrue([ for value in var.exclude.email : true if account.email != value])  ]


  # STEP 10 - exclude status
  is_exclude_status_set = var.exclude != null && var.exclude.status != null && try(length(var.exclude.status) > 0, false)
  search_step10_exclude_status = !local.is_exclude_status_set ? local.search_step9_exclude_email : [ for account in local.search_step9_exclude_email : account if anytrue([ for value in var.exclude.status : true if account.status != value])  ]


  ## STEP 11 - exclude name
  is_exclude_name_set = var.exclude != null && var.exclude.name != null
  search_step11_exclude_name = !local.is_exclude_name_set ? local.search_step10_exclude_status : local.exclude_name_matcher

  exclude_name_matcher = !local.is_exclude_name_set ? [] : var.exclude.name.matcher == "startswith" ? local.exclude_name_startswith : var.exclude.name.matcher == "endswith" ? local.exclude_name_endswith : var.exclude.name.matcher == "equals" ? local.exclude_name_equals : []
  exclude_name_startswith = !local.is_exclude_name_set ? [] : [ for account in local.search_step10_exclude_status : account if anytrue([ for prefix in var.exclude.name.values : true if !startswith(account.name, prefix)]) ]
  exclude_name_endswith = !local.is_exclude_name_set ? [] : [ for account in local.search_step10_exclude_status : account if anytrue([ for suffix in var.exclude.name.values : true if !endswith(account.name, suffix)]) ]
  exclude_name_equals = !local.is_exclude_name_set ? [] : [ for account in local.search_step10_exclude_status : account if anytrue([ for value in var.exclude.name.values : true if account.name != value]) ]


  ## STEP 12 - exclude tags
  is_exclude_tags_set = var.exclude != null && var.exclude.tags != null && try(length(var.exclude.tags) > 0, false)
  search_step12_exclude_tags = !local.is_exclude_tags_set ? local.search_step11_exclude_name : local.exclude_tags_result

  exclude_tags_accounts_containing_all_tags_from_filter_option = !local.is_exclude_tags_set ? [] : [ for account in local.search_step11_exclude_name : account if alltrue([ for tag_name, search_strings in var.exclude.tags : lookup(account.tags, tag_name, null) != null ]) ]
  exclude_tags_result = !local.is_exclude_tags_set ? [] : [ for account in local.exclude_tags_accounts_containing_all_tags_from_filter_option : account if alltrue([ for tag_name, search_strings in var.exclude.tags : anytrue([ for search_string in search_strings : account.tags[tag_name] == search_string ]) ]) ]


  ## STEP 13 - include or exclude management account
  search_step13_include_or_exclude_management_account = [
    for entry in local.search_step12_exclude_tags : entry if entry["id"] != local.management_account_id || var.include_management_account
  ]

  ## STEP 14 - grouping
  is_group_by_tag_set = var.group_by_tag != null && try(length(var.group_by_tag) > 0, false)
  search_step14_grouping = local.is_group_by_tag_set ? {
    for account in local.search_step13_include_or_exclude_management_account :
      lookup(account.tags, var.group_by_tag, local.search_result_group_id_missing_key) => account...
  } : {
    for account in local.search_step13_include_or_exclude_management_account :
      account.id => account...
  }

  # Result
  search_result = local.search_step14_grouping
}