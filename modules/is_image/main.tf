resource "ibm_is_image" "this"{
  name              = var.name
  href              = var.href
  operating_system  = var.operating_system
}
