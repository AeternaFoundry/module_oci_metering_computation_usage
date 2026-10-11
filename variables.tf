variable "metering_computation_usages" {
  description = <<EOT
Map of metering_computation_usages, attributes below
Required:
    - granularity
    - tenant_id
    - time_usage_ended
    - time_usage_started
Optional:
    - compartment_depth
    - filter
    - group_by
    - is_aggregate_by_time
    - query_type
    - forecast (block):
        - forecast_type (optional)
        - time_forecast_ended (required)
        - time_forecast_started (optional)
    - group_by_tag (block):
        - key (optional)
        - namespace (optional)
        - value (optional)
    - timeouts (block):
        - create (optional)
        - delete (optional)
        - update (optional)
EOT

  type = map(object({
    granularity          = string
    tenant_id            = string
    time_usage_ended     = string
    time_usage_started   = string
    compartment_depth    = optional(number)
    filter               = optional(string)
    group_by             = optional(list(string))
    is_aggregate_by_time = optional(bool)
    query_type           = optional(string)
    forecast = optional(object({
      forecast_type         = optional(string)
      time_forecast_ended   = string
      time_forecast_started = optional(string)
    }))
    group_by_tag = optional(list(object({
      key       = optional(string)
      namespace = optional(string)
      value     = optional(string)
    })))
    timeouts = optional(object({
      create = optional(string)
      delete = optional(string)
      update = optional(string)
    }))
  }))
  validation {
    condition = alltrue([
      for k, v in var.metering_computation_usages : (
        v.filter == null || (length(v.filter) >= 1)
      )
    ])
    error_message = "[from validateFilterJson: invalid when len(value) < 1]"
  }
  # Note: 2 additional provider-side validators are enforced at apply time but not mirrored as validation{} blocks here (bespoke or non-mechanically-translatable).
}

