variable "group_by" {
  type = string
  default = "account_id"
  description = "Group by one of the given properties. This can be either 'account_id', 'account_name' or a tag which is provided by all accounts."
}

variable "include_management_account" {
  type = bool
  default = true
  description = "Whether or not the search result should include the organization's management account."
}