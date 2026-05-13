variable "location" {
  default = "Denmark East"
}

variable "resource_group_name" {
  default = "denmark-east-rg"
}

variable "image_id" {
  default = "/subscriptions/50b00215-bc86-413d-a70f-7f58601e6267/resourceGroups/denmark-east-rg/providers/Microsoft.Compute/galleries/rhel10/images/1.0.0"
}

variable "components" {
  default = {
    frontend = "Standard_B1ms"
    mysql = "Standard_B1ms"
    catalogue = "Standard_B1ms"
    # valkey = "Standard_B1ms"
    # mongodb = "Standard_B1ms"
    # rabbitmq = "Standard_B1ms"
    # user = "Standard_B1ms"
    # cart = "Standard_B1ms"
    # shipping = "Standard_B1ms"
    # order = "Standard_B1ms"
    # notification = "Standard_B1ms"
    # ratings = "Standard_B1ms"
    # payment = "Standard_B1ms"
  }
}