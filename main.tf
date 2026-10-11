resource "oci_metering_computation_usage" "metering_computation_usages" {
  for_each = var.metering_computation_usages

  granularity          = each.value.granularity
  tenant_id            = each.value.tenant_id
  time_usage_ended     = each.value.time_usage_ended
  time_usage_started   = each.value.time_usage_started
  compartment_depth    = each.value.compartment_depth
  filter               = each.value.filter
  group_by             = each.value.group_by
  is_aggregate_by_time = each.value.is_aggregate_by_time
  query_type           = each.value.query_type

  dynamic "forecast" {
    for_each = each.value.forecast != null ? [each.value.forecast] : []
    content {
      forecast_type         = forecast.value.forecast_type
      time_forecast_ended   = forecast.value.time_forecast_ended
      time_forecast_started = forecast.value.time_forecast_started
    }
  }

  dynamic "group_by_tag" {
    for_each = each.value.group_by_tag != null ? each.value.group_by_tag : []
    content {
      key       = group_by_tag.value.key
      namespace = group_by_tag.value.namespace
      value     = group_by_tag.value.value
    }
  }

  dynamic "timeouts" {
    for_each = each.value.timeouts != null ? [each.value.timeouts] : []
    content {
      create = timeouts.value.create
      delete = timeouts.value.delete
      update = timeouts.value.update
    }
  }
}

