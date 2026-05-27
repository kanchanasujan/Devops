env      = "dev"
location = "Denmark East"
rgname   = "denmark-east-rg"
image_id = "/subscriptions/50b00215-bc86-413d-a70f-7f58601e6267/resourceGroups/denmark-east-rg/providers/Microsoft.Compute/galleries/rhel10/images/1.0.0"
subnet_id = "/subscriptions/50b00215-bc86-413d-a70f-7f58601e6267/resourceGroups/denmark-east-rg/providers/Microsoft.Network/virtualNetworks/workstation-vnet/subnets/workstation-subnet"

db = {
    mysql = {}
  # valkey   = {}
  # mongodb  = {}
  # rabbitmq = {}
}

apps = {
  catalogue    = {
    port = 8002
  }
  # user         = {
  #   port = 8001
  # }
  # cart         = {
  #   port = 8003
  # }
  # shipping     = {
  #   port = 8004
  # }
  # order        = {
  #   port = 8007
  # }
  # notification = {
  #   port = 8008
  # }
  # ratings      = {
  #   port = 8006
  # }
  # payment      = {
  #   port = 8005
  #}
}

ui = {
  frontend = {
    port = 80
  }
}
