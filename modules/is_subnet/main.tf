resource "ibm_is_subnet" "this" {
  name            = var.subnet_name
  vpc             = var.vpc_id
  zone            = var.zone
  total_ipv4_address_count  = var.total_ipv4_address_count
}
