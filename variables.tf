variable "include_management_account" {
  type = bool
  default = true
  description = "Whether or not the search result should include the organization's management account."
}

variable "include" {
  type = object({
    id = optional(set(string))
    arn = optional(set(string))
    name = optional(object({
      matcher  = string
      values   = set(string)
    }))
    email = optional(set(string))
    status = optional(set(string)) # Valid Values: ACTIVE | SUSPENDED | PENDING_CLOSURE  source: https://docs.aws.amazon.com/organizations/latest/APIReference/API_Account.html
    tags = optional(map(set(string)))
  })
  default = {
    status = ["ACTIVE"]
  }
  description = "A filter taking a map to determine which accounts to include in the result set. Key and value must represent one of the given properties. This can be either 'account_id', 'account_name' or one of the tags provided by the account. Multiple entries are connected by AND."
}

variable "exclude" {
  type = object({
    id = optional(set(string))
    arn = optional(set(string))
    name = optional(object({
      matcher  = string
      values   = set(string)
    }))
    email = optional(set(string))
    status = optional(set(string)) # Valid Values: ACTIVE | SUSPENDED | PENDING_CLOSURE  source: https://docs.aws.amazon.com/organizations/latest/APIReference/API_Account.html
    tags = optional(map(set(string)))
  })
  default = {}
  description = "A filter taking a map to determine which accounts to exclude from the result set. Key and value must represent one of the given properties. This can be either 'account_id', 'account_name' or one of the tags provided by the account. Multiple entries are connected by AND."
}

variable "group_by_tag" {
  type = string
  default = ""
  description = "Group by one of the tags provided by the accounts. If you choose a tag which is not provided by all account, then those accounts which don't provide the tag will be listed in a separate group. The name of this group can be accessed by using 'output.group_id_missing_key'"
}