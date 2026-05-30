variable "location" {
  default = "Denmark East"
}

variable "resource_group_name" {
  default = "denmark-east-rg"
}

variable "image_id" {
  default = "/subscriptions/50b00215-bc86-413d-a70f-7f58601e6267/resourceGroups/denmark-east-rg/providers/Microsoft.Compute/galleries/rhel/images/1.0.0"
}

variable "subnet_id" {
  default = "/subscriptions/50b00215-bc86-413d-a70f-7f58601e6267/resourceGroups/denmark-east-rg/providers/Microsoft.Network/virtualNetworks/workstation-vnet/subnets/workstation-subnet"
}
