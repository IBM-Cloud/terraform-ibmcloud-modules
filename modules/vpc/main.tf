module "resource_group" {
  #source = "github.com/IBM-Cloud/terraform-ibmcloud-modules.git//modules/resource_group"
  #https://github.com/IBM-Cloud/terraform-ibmcloud-modules.git
  source = "../resource_group"
  resource_group_name = var.resource_group_name
}

#########1#########2#########3#########4#########5#########6#########7#########8
# Resources
#########1#########2#########3#########4#########5#########6#########7#########8
resource "ibm_is_vpc" "this" {
  name           	        = var.vpc_name
  address_prefix_management = var.address_prefix_management
  resource_group            = module.resource_group.resource_group_id
  classic_access            = var.classic_access
}
