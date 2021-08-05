

resource "ibm_is_vpc" "vpc" {
  #count   = var.vpc_count
  #name    = "vpc-${var.prefix}-${var.vpc_count[count.index]}"
  #name    = "vpc-${var.prefix}-${var.}"
  name     = "${var.prefix}-vpc"
}
