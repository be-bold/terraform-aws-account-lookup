# Organization id
output "organization_id" {
  value = data.aws_organizations_organization.this.id
  description = "The id of the AWS organization."
}


# Management account
output "management_account_id" {
  value = local.management_account_id
  description = "The AWS account id of the organizations management account."
}

output "management_account_name" {
  value = local.management_account_name
  description = "The name of the organizations management account."
}


# Mappings
output "mapping_id_to_name" {
  value = local.mapping_id_to_name
  description = "A map which contains the id of the accounts as key and the corresponding account name as value"
}

output "mapping_name_to_id" {
  value = local.mapping_name_to_id
  description = "A map which contains the name of the accounts as key and the corresponding account id as value"
}

output "mapping_id_to_tags" {
  value = local.mapping_id_to_tags
  description = "A map containing the account id as key and the corresponding tags of the account as value"
}

output "mapping_name_to_tags" {
  value = local.mapping_name_to_tags
  description = "A map containing the account name as key and the corresponding tags of the account as value"
}


# Account list
output "account_list" {
  value = local.account_list
  description = "A list of the accounts and all their properties."
}