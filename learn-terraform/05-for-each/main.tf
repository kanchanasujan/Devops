variable "abc" {
  default = {
    x = 100
    y = 500
    z = 200
  }
}


resource "null_resource" "test" {
  for_each = var.abc
}
