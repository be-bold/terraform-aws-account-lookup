variable "input" {
  type = list(object({
    id = string
    arn = string
    name = string
    email = string
    state = string
    tags = map(string)
    joined = object({
      method = string
      timestamp = string
    })
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
    condition = var.input != null && alltrue([ for entry in var.input != null ? var.input : [] : try(contains(["PENDING_ACTIVATION", "ACTIVE", "SUSPENDED", "PENDING_CLOSURE", "CLOSED"], entry.state), false) ])
    error_message = "{input.state} contains invalid value(s). See AWS documentation: https://docs.aws.amazon.com/organizations/latest/APIReference/API_Account.html"
  }

  validation {
    condition = var.input != null && alltrue([ for entry in var.input != null ? var.input : [] : entry.tags != null ])
    error_message = "{input.tags} contains invalid value(s). See AWS documentation: https://docs.aws.amazon.com/organizations/latest/APIReference/API_Account.html"
  }

  validation {
    condition = var.input != null && alltrue([ for entry in var.input != null ? var.input : [] : entry.joined != null ])
    error_message = "{input.joined} must not be null"
  }

  validation {
    condition = var.input != null && alltrue([ for entry in var.input != null ? var.input : [] : entry.joined != null && try(contains(["CREATED", "INVITED"], entry.joined.method), false) ])
    error_message = "{input.joined.method} contains invalid value(s). See AWS documentation: https://docs.aws.amazon.com/organizations/latest/APIReference/API_Account.html"
  }

  validation {
    condition = var.input != null && alltrue([ for entry in var.input != null ? var.input : [] : entry.joined != null && try(formatdate("YYYY", entry.joined.timestamp), null) != null ])
    error_message = "{input.joined.timestamp} contains invalid value(s). See AWS documentation: https://docs.aws.amazon.com/organizations/latest/APIReference/API_Account.html"
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
    state = optional(set(string))
    tags = optional(map(set(string)))
    joined = optional(object({
      method = optional(set(string))
      timestamp = optional(object({
        is = string
        other_timestamp = string
      }))
    }))
  })

  default = {
    state = ["ACTIVE"]
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
    error_message = "{include.name.matcher} must be one of ['startswith', 'endswith', 'equals', 'contains', 'regex']"
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
    condition = alltrue([ for entry in var.include.state != null ? var.include.state : [] : contains(["PENDING_ACTIVATION", "ACTIVE", "SUSPENDED", "PENDING_CLOSURE", "CLOSED"], entry) ])
    error_message = "{include.state} contains invalid value(s). See AWS documentation: https://docs.aws.amazon.com/organizations/latest/APIReference/API_Account.html"
  }

  validation {
    condition = var.include.tags == null || (var.include.tags != null && try(length(var.include.tags) > 0, false))
    error_message = "{include.tags} if tags are set then the map must not be empty."
  }

  validation {
    condition = var.include.joined == null || alltrue([ for entry in var.include.joined.method != null ? var.include.joined.method : [] : try(contains(["CREATED", "INVITED"], entry)) ])
    error_message = "{include.joined.method} must be one of ['CREATED', 'INVITED'] or null."
  }

  validation {
    condition = var.include.joined == null || var.include.joined.timestamp == null || (var.include.joined.timestamp != null && try(contains(["before", "equals", "after"], var.include.joined.timestamp.is), false))
    error_message = "{include.joined.timestamp.is} must be one of ['before', 'equals', 'after]."
  }

  validation {
    condition = var.include.joined == null || var.include.joined.timestamp == null || (var.include.joined.timestamp != null && try(formatdate("YYYY", var.include.joined.timestamp.other_timestamp), null) != null)
    error_message = "{include.joined.timestamp.other_timestamp} must be a valid RFC 3339 timestamp."
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
    state = optional(set(string))
    tags = optional(map(set(string)))
    joined = optional(object({
      method = optional(set(string))
      timestamp = optional(object({
        is = string
        other_timestamp = string
      }))
    }))
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
    error_message = "{exclude.name.matcher} must be one of ['startswith', 'endswith', 'equals', 'contains', 'regex']"
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
    condition = alltrue([ for entry in var.exclude.state != null ? var.exclude.state : [] : contains(["PENDING_ACTIVATION", "ACTIVE", "SUSPENDED", "PENDING_CLOSURE", "CLOSED"], entry) ])
    error_message = "{exclude.state} contains invalid value(s). See AWS documentation: https://docs.aws.amazon.com/organizations/latest/APIReference/API_Account.html"
  }

  validation {
    condition = var.exclude.tags == null || (var.exclude.tags != null && try(length(var.exclude.tags) > 0, false))
    error_message = "{exclude.tags} if tags are set then the map must not be empty."
  }

  validation {
    condition = var.exclude.joined == null || alltrue([ for entry in var.exclude.joined.method != null ? var.exclude.joined.method : [] : try(contains(["CREATED", "INVITED"], entry)) ])
    error_message = "{exclude.joined.method} must be one of ['CREATED', 'INVITED'] or null."
  }

  validation {
    condition = var.exclude.joined == null || var.exclude.joined.timestamp == null || (var.exclude.joined.timestamp != null && try(contains(["before", "equals", "after"], var.exclude.joined.timestamp.is), false))
    error_message = "{exclude.joined.timestamp.is} must be one of ['before', 'equals', 'after]."
  }

  validation {
    condition = var.exclude.joined == null || var.exclude.joined.timestamp == null || (var.exclude.joined.timestamp != null && try(formatdate("YYYY", var.exclude.joined.timestamp.other_timestamp), null) != null)
    error_message = "{include.joined.timestamp.other_timestamp} must be a valid RFC 3339 timestamp."
  }
}

variable "group_by_tag" {
  type = object({
    tag = string
    include_ungrouped_accounts = optional(bool)
    ungrouped_key = optional(string)
  })

  default = null

  description = <<EOF
    Groups accounts by a specific tag.
    Specify the tag name in `tag`.

    Not all accounts may provide this tag.
    With `include_ungrouped_accounts`, you can decide whether accounts without this tag
    should be included in the results.

    If set to `true`, all accounts missing the tag are grouped under a special key,
    defined by `ungrouped_key`.
EOF

  validation {
    condition = var.group_by_tag == null || (var.group_by_tag != null && var.group_by_tag.tag != null && try(length(var.group_by_tag.tag) > 0, false))
    error_message = "If you set group_by_tag then tag must not be null or empty."
  }
}