variable "location" {
  default = "Denmark East"
}

variable "resource_group_name" {
  default = "denmark-east-rg"
}

variable "image_id" {
  default = "/subscriptions/50b00215-bc86-413d-a70f-7f58601e6267/resourceGroups/denmark-east-rg/providers/Microsoft.Compute/galleries/rhel/images/1.0.0"
}

variable "components" {
  default = {
    frontend = "Standard_B1s"
    mysql = "Standard_B1s"
    catalogue = "Standard_B1s"
    valkey = "Standard_B1s"
    mongodb = "Standard_B1s"
    rabbitmq = "Standard_B1s"
    user = "Standard_B1s"
    cart = "Standard_B1s"
    shipping = "Standard_B1s"
    order = "Standard_B1s"
    notification = "Standard_B1s"
    ratings = "Standard_B1s"
    payment = "Standard_B1s"
  } 
}