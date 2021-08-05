resource "ibm_is_instance" "this" {
  count           = var.vsi_count
  name 	          = "${var.zone}-${var.vsi_name}-${count.index}"
  vpc 		  = var.vpc_id
  zone 		  = var.zone
  image           = var.image_id
  profile         = var.profile
  keys            = [var.ssh_key_id]
  user_data       = var.user_data

  boot_volume {
    name       = "${var.zone}-${var.bv_name}-${count.index}"
    encryption = var.bv_encryption	
  }
  
  primary_network_interface {
    name            = "${var.zone}-${var.primary_nif_name}"
    subnet          = var.subnet_id
    security_groups = [var.sg_id]
  }

  volumes           = length(var.volume_ids) != 0 ?[var.volume_ids[count.index]]: []
  resource_group    = var.resource_group_id

  # Dedicated host
  placement_target  = var.placement_target

  depends_on = [
    var.vsi_depends_on,
  ]

  timeouts {
    delete = "5m"
  }
}
