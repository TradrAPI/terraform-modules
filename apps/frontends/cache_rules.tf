
resource "local_file" "example" {
  for_each = {
    for partition, data in local.var.partitions : partition => data 
    if contains(keys(data), "api")
  }

  content  = each.value.api
  filename = "${path.module}/folder/${each.key}"
}