data ibm_resource_group "resource_group" {
  name = var.resource_group_name
}

#########1#########2#########3#########4#########5#########6#########7#########8
# Resources
#########1#########2#########3#########4#########5#########6#########7#########8
resource "ibm_is_vpc" "this" {
  name           	        = var.vpc_name
  address_prefix_management = var.address_prefix_management
  resource_group            = data.ibm_resource_group.resource_group.id
  classic_access            = var.classic_access
}


