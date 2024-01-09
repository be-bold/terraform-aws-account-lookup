output "result_group_id_missing_key" {
  value = local.result_group_id_missing_key
  description = "Name of the group in which accounts will be put if they don't provide the tag set in the input parameter 'group_by_tag'."
}

output "result" {
  value = local.result
  description = "The result which can be refined by setting the input parameters of this module."
}