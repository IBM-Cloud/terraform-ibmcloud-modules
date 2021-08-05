# IBM Confidential
# OCO Source Materials
# CLD-68685-1602740630
# (c) Copyright IBM Corp. 2020
# The source code for this program is not published or otherwise
# divested of its trade secrets, irrespective of what has been
# deposited with the U.S. Copyright Office.


resource "ibm_is_vpc" "vpc" {
  #count   = var.vpc_count
  #name    = "vpc-${var.prefix}-${var.vpc_count[count.index]}"
  #name    = "vpc-${var.prefix}-${var.}"
  name     = "${var.prefix}-vpc"
}
