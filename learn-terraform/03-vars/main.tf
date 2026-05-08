variable "some_string" {
  default = "Some thing"
}

variable "some_number" {
  default = 100
}

variable "some_boolean" {
  default = true
}

variable "some_list" {
  default = [ "Some", 100, true, false, 20.001 ]
}

variable "some_map" {
  default = {
    a = "Some"
    b = 100
    c = false
  }
}

output "some_string" {
  value = var.some_string
}

output "some_list_0" {
  value = var.some_list[0]
}

output "some_map_a" {
  value = var.some_map["a"]
}

output "number" {
  value = "Some Number - ${var.some_number}"
}
