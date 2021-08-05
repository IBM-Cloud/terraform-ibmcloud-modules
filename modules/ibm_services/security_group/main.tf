

resource "ibm_is_security_group" "sg" {
  #count   = var.sg_count
  name    = "sg-${var.prefix}"
  vpc     = var.vpc_id
}
