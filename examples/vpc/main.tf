module "is_vpc" {
  source = "github.com/IBM-Cloud/terraform-ibmcloud-modules.git?ref=main//modules/is_vpc"

  vpc_name = "example-vpc"
}