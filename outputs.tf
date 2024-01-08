# Organization id
output "organization_id" {
  value = data.aws_organizations_organization.this.id
  description = "The id of the AWS organization."
}


# Management account
output "management_account_id" {
  value = local.management_account_id
  description = "The AWS account id of the organization's management account."
}

output "management_account_name" {
  value = local.management_account_name
  description = "The name of the organization's management account."
}


# Lists of account ids
output "organization_members_account_ids" {
  value = local.member_account_ids
  description = "A list of AWS account ids of all member accounts. It doesn't include the organization's management account."
}

output "all_account_ids" {
  value = local.all_account_ids
  description = "A list of all AWS account ids of the organization. This includes both management account as well as all member accounts."
}


# Mapping between account id and name
output "organization_members_mapping_name_to_account_id" {
  value = local.organization_members_mapping_name_to_account_id
  description = "A map which contains the name of the accounts as key and the corresponding account id as value for all member accounts of an organization. It doesn't include the organization's management account."
}

output "organization_members_mapping_account_id_to_name" {
  value = local.organization_members_mapping_account_id_to_name
  description = "A map which contains the id of the accounts as key and the corresponding account name as value for all member accounts of an organization. It doesn't include the organization's management account."
}

output "all_accounts_mapping_name_to_account_id" {
  value = local.all_accounts_mapping_name_to_account_id
  description = "A map which contains the name of the accounts as key and the corresponding account id as value for all accounts of the organization including the management account."
}

output "all_accounts_mapping_account_id_to_name" {
  value = local.all_accounts_mapping_account_id_to_name
  description = "A map which contains the id of the accounts as key and the corresponding account name as value for all accounts of the organization including the management account."
}


# Tagging
output "all_accounts_tags_by_account_id" {
  value = local.all_accounts_tags_by_account_id
  description = "A map containing the account id as key and the corresponding tags of the account as value for all accounts including the management account."
}

output "all_accounts_tags_by_account_name" {
  value = local.all_accounts_tags_by_account_name
  description = "A map containing the account name as key and the corresponding tags of the account as value for all accounts including the management account."
}

output "organization_members_account_tags_by_account_id" {
  value = local.organization_members_account_tags_by_account_id
  description = "A map containing the account id as key and the corresponding tags of the account as value. Contains member accounts only."
}

output "organization_members_account_tags_by_account_name" {
  value = local.organization_members_account_tags_by_account_name
  description = "A map containing the account name as key and the corresponding tags of the account as value. Contains member accounts only."
}