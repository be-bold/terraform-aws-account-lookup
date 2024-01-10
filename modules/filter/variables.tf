variable "input" {
  type = list(object({
    id = string
    arn = string
    name = string
    email = string
    status = string
    tags = map(string)
  }))

  description = "List of accounts on which the filter configuration is being applied. Use the lookup module as source: https://registry.terraform.io/modules/be-bold/account-lookup/aws/latest"

  validation {
    condition = var.input != null && alltrue([ for entry in var.input != null ? var.input : [] : can(regex("^\\d{12}$", entry.id)) ])
    error_message = "{input.id} contains invalid value(s). See AWS documentation: https://docs.aws.amazon.com/organizations/latest/APIReference/API_Account.html"
  }

  validation {
    condition = var.input != null && alltrue([ for entry in var.input != null ? var.input : [] : can(regex("^arn:aws:organizations::\\d{12}:account\\/o-[a-z0-9]{10,32}\\/\\d{12}$", entry.arn)) ])
    error_message = "{input.arn} contains invalid value(s). See AWS documentation: https://docs.aws.amazon.com/organizations/latest/APIReference/API_Account.html"
  }

  validation {
    condition = var.input != null && alltrue([ for entry in var.input != null ? var.input : [] : can(regex("^[\\s\\S]*$", entry.name)) ])
    error_message = "{input.name} contains invalid value(s). See AWS documentation: https://docs.aws.amazon.com/organizations/latest/APIReference/API_Account.html"
  }

  validation {
    condition = var.input != null && alltrue([ for entry in var.input != null ? var.input : [] : can(regex("^[\\s\\S]+@[\\s\\S]+\\.[\\s\\S]+$", entry.email)) ])
    error_message = "{input.email} contains invalid value(s). See AWS documentation: https://docs.aws.amazon.com/organizations/latest/APIReference/API_Account.html"
  }

  validation {
    condition = var.input != null && alltrue([ for entry in var.input != null ? var.input : [] : try(contains(["ACTIVE", "SUSPENDED", "PENDING_CLOSURE"], entry.status), false) ])
    error_message = "{input.status} contains invalid value(s). See AWS documentation: https://docs.aws.amazon.com/organizations/latest/APIReference/API_Account.html"
  }

  validation {
    condition = var.input != null && alltrue([ for entry in var.input != null ? var.input : [] : entry.tags != null ])
    error_message = "{input.tags} contains invalid value(s). See AWS documentation: https://docs.aws.amazon.com/organizations/latest/APIReference/API_Account.html"
  }
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

  description = "Options to filter the input for values that must be included. The include filter is being evaluated first. If you set multiple properties then these will be linked by AND. If you set multiple values in a set of a single property then these will be linked by OR."

  validation {
    condition = alltrue([ for entry in var.include.id != null ? var.include.id : [] : can(regex("^\\d{12}$", entry)) ])
    error_message = "{include.id} contains invalid value(s). See AWS documentation: https://docs.aws.amazon.com/organizations/latest/APIReference/API_Account.html"
  }

  validation {
    condition = alltrue([ for entry in var.include.arn != null ? var.include.arn : [] : can(regex("arn:aws:organizations::\\d{12}:account/o-[a-z0-9]{10,32}/\\d{12}", entry)) ])
    error_message = "{include.arn} contains invalid value(s). See AWS documentation: https://docs.aws.amazon.com/organizations/latest/APIReference/API_Account.html"
  }

  validation {
    condition = var.include.name == null || (var.include.name != null && try(contains(["startswith", "endswith", "equals", "contains", "regex"], var.include.name.matcher), false))
    error_message = "{include.name.matcher} must be one of [startswith, endswith, equals, contains, regex]"
  }

  validation {
    condition = var.include.name == null || (var.include.name != null && can(length(var.include.name.values) > 0))
    error_message = "{include.name.values} must not be empty."
  }

  validation {
    condition = alltrue([ for entry in var.include.email != null ? var.include.email : [] : can(regex("[^\\s@]+@[^\\s@]+\\.[^\\s@]+", entry)) ])
    error_message = "{include.email} contains invalid value(s). See AWS documentation: https://docs.aws.amazon.com/organizations/latest/APIReference/API_Account.html"
  }

  validation {
    condition = alltrue([ for entry in var.include.status != null ? var.include.status : [] : contains(["ACTIVE", "SUSPENDED", "PENDING_CLOSURE"], entry) ])
    error_message = "{include.status} contains invalid value(s). See AWS documentation: https://docs.aws.amazon.com/organizations/latest/APIReference/API_Account.html"
  }

  validation {
    condition = var.include.tags == null || (var.include.tags != null && try(length(var.include.tags) > 0, false))
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

  description = "Options to filter the input for values that must be excluded. The exclude filter is evaluated after the include filter. If you set multiple properties then these will be linked by AND. If you set multiple values in a set of a single property then these will be linked by AND as well."

  validation {
    condition = alltrue([ for entry in var.exclude.id != null ? var.exclude.id : [] : can(regex("^\\d{12}$", entry)) ])
    error_message = "{exclude.id} contains invalid value(s). See AWS documentation: https://docs.aws.amazon.com/organizations/latest/APIReference/API_Account.html"
  }

  validation {
    condition = alltrue([ for entry in var.exclude.arn != null ? var.exclude.arn : [] : can(regex("arn:aws:organizations::\\d{12}:account/o-[a-z0-9]{10,32}/\\d{12}", entry)) ])
    error_message = "{exclude.arn} contains invalid value(s). See AWS documentation: https://docs.aws.amazon.com/organizations/latest/APIReference/API_Account.html"
  }

  validation {
    condition = var.exclude.name == null || (var.exclude.name != null && try(contains(["startswith", "endswith", "equals", "contains", "regex"], var.exclude.name.matcher), false))
    error_message = "{exclude.name.matcher} must be one of [startswith, endswith, equals, contains, regex]"
  }

  validation {
    condition = var.exclude.name == null || (var.exclude.name != null && can(length(var.exclude.name.values) > 0))
    error_message = "{exclude.name.values} must not be empty."
  }

  validation {
    condition = alltrue([ for entry in var.exclude.email != null ? var.exclude.email : [] : can(regex("[^\\s@]+@[^\\s@]+\\.[^\\s@]+", entry)) ])
    error_message = "{exclude.email} contains invalid value(s). See AWS documentation: https://docs.aws.amazon.com/organizations/latest/APIReference/API_Account.html"
  }

  validation {
    condition = alltrue([ for entry in var.exclude.status != null ? var.exclude.status : [] : contains(["ACTIVE", "SUSPENDED", "PENDING_CLOSURE"], entry) ])
    error_message = "{exclude.status} contains invalid value(s). See AWS documentation: https://docs.aws.amazon.com/organizations/latest/APIReference/API_Account.html"
  }

  validation {
    condition = var.exclude.tags == null || (var.exclude.tags != null && try(length(var.exclude.tags) > 0, false))
    error_message = "{exclude.tags} if tags are set then the map must not be empty."
  }
}

variable "group_by_tag" {
  type = string
  default = ""
  description = "Group by one of the accounts tags. If you choose a tag which is not provided by all accounts, then those accounts which don't provide the tag will be listed in a separate group. The name of this group can be accessed by using 'output.search_result_group_id_missing_key'"
}