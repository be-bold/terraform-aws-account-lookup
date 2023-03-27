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
    status = optional(set(string))
    tags = optional(map(set(string)))
  })
  default = {
    status = ["ACTIVE"]
  }
  description = "A filter taking a map to determine which accounts to include in the result set. Key and value must represent one of the given properties. This can be either 'account_id', 'account_name' or one of the tags provided by the account. Multiple entries are connected by AND."

  validation {
    condition = var.include.id == null || can(alltrue([ for entry in var.include.id : can(regex("^\\d{12}$", entry)) ]))
    error_message = "{include.id} contains invalid value(s). See AWS documentation: https://docs.aws.amazon.com/organizations/latest/APIReference/API_Account.html"
  }

  validation {
    condition = var.include.arn == null || can(alltrue([ for entry in var.include.arn : can(regex("arn:aws:organizations::\\d{12}:account/o-[a-z0-9]{10,32}/\\d{12}", entry)) ]))
    error_message = "{include.arn} contains invalid value(s). See AWS documentation: https://docs.aws.amazon.com/organizations/latest/APIReference/API_Account.html"
  }

  validation {
    condition = var.include.name == null || var.include.name != null && can(contains(["startswith", "endswith", "equals"], var.include.name.matcher))
    error_message = "{include.name.matcher} must be one of [startswith, endswith, equals]"
  }

  validation {
    condition = var.include.name == null || var.include.name != null && can(length(var.include.name.values) > 0)
    error_message = "{include.name.values} must not be empty."
  }

  validation {
    condition = var.include.email == null || can(alltrue([ for entry in var.include.email : can(regex("[^\\s@]+@[^\\s@]+\\.[^\\s@]+", entry)) ]))
    error_message = "{include.email} contains invalid value(s). See AWS documentation: https://docs.aws.amazon.com/organizations/latest/APIReference/API_Account.html"
  }

  validation {
    condition = var.include.status == null || can(alltrue([ for entry in var.include.status : contains(["ACTIVE", "SUSPENDED", "PENDING_CLOSURE"], entry) ]))
    error_message = "{include.status} contains invalid value(s). See AWS documentation: https://docs.aws.amazon.com/organizations/latest/APIReference/API_Account.html"
  }

  validation {
    condition = var.include.tags == null || var.include.tags != null && can(length(var.include.tags) > 0)
    error_message = "{include.tags} if tags are set then the map must not be empty."
  }
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
    status = optional(set(string))
    tags = optional(map(set(string)))
  })
  default = {}
  description = "A filter taking a map to determine which accounts to exclude from the result set. Key and value must represent one of the given properties. This can be either 'account_id', 'account_name' or one of the tags provided by the account. Multiple entries are connected by AND."

  validation {
    condition = var.exclude.id == null || can(alltrue([ for entry in var.exclude.id : can(regex("^\\d{12}$", entry)) ]))
    error_message = "{exclude.id} contains invalid value(s). See AWS documentation: https://docs.aws.amazon.com/organizations/latest/APIReference/API_Account.html"
  }

  validation {
    condition = var.exclude.arn == null || can(alltrue([ for entry in var.exclude.arn : can(regex("arn:aws:organizations::\\d{12}:account/o-[a-z0-9]{10,32}/\\d{12}", entry)) ]))
    error_message = "{exclude.arn} contains invalid value(s). See AWS documentation: https://docs.aws.amazon.com/organizations/latest/APIReference/API_Account.html"
  }

  validation {
    condition = var.exclude.name == null || var.exclude.name != null && can(contains(["startswith", "endswith", "equals"], var.exclude.name.matcher))
    error_message = "{exclude.name.matcher} must be one of [startswith, endswith, equals]"
  }

  validation {
    condition = var.exclude.name == null || var.exclude.name != null && can(length(var.exclude.name.values) > 0)
    error_message = "{exclude.name.values} must not be empty."
  }

  validation {
    condition = var.exclude.email == null || can(alltrue([ for entry in var.exclude.email : can(regex("[^\\s@]+@[^\\s@]+\\.[^\\s@]+", entry)) ]))
    error_message = "{exclude.email} contains invalid value(s). See AWS documentation: https://docs.aws.amazon.com/organizations/latest/APIReference/API_Account.html"
  }

  validation {
    condition = var.exclude.status == null || can(alltrue([ for entry in var.exclude.status : contains(["ACTIVE", "SUSPENDED", "PENDING_CLOSURE"], entry) ]))
    error_message = "{exclude.status} contains invalid value(s). See AWS documentation: https://docs.aws.amazon.com/organizations/latest/APIReference/API_Account.html"
  }

  validation {
    condition = var.exclude.tags == null || var.exclude.tags != null && can(length(var.exclude.tags) > 0)
    error_message = "{exclude.tags} if tags are set then the map must not be empty."
  }
}

variable "group_by_tag" {
  type = string
  default = ""
  description = "Group by one of the tags provided by the accounts. If you choose a tag which is not provided by all account, then those accounts which don't provide the tag will be listed in a separate group. The name of this group can be accessed by using 'output.group_id_missing_key'"
}