

resource "ibm_is_volume" "this" {
  count          = var.vol_count !=0 ?var.vsi_count: 0 
  name           = "${var.zone}-${var.vol_name}-${count.index}"
  profile        = var.vol_profile
  zone           = var.zone
  capacity       = var.vol_size_in_gb
  encryption_key = var.encryption_key
  resource_group = var.resource_group_id

  timeouts {
    delete = "2m"
  }
}

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

  volumes           = length(ibm_is_volume.this) !=0 ?[ibm_is_volume.this[count.index].id]: []
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
