
#### Expectation is public-sshkey name present on stgaing environment ######
data "ibm_is_ssh_key" "public_ssh_key" {
  name = "test-public-key-v1-do-not-delete"
}

locals {
  ssh_private_key = file(pathexpand("~/.ssh/test-private-key-v1-do-not-delete"))
}

module "resource_group" {
  source = "../../ibm/resource_group_id"
  ibm_resource_group = var.resource_group
}

module "bastion_fip" {
  source = "../../ibm_is/floating_ip"

  floating_ip_name = "bastion-fip-${var.suffix}"
  floating_ip_target = ibm_is_instance.bastion.primary_network_interface[0].id

}

module "vpc" {
  source = "../../ibm_is/vpc"

  vpc_name                = "vpc-${var.suffix}"
  vpc_address_prefix_name = "ap-${var.suffix}"
  zone_vpc_address_prefix = var.zone_vpc_address_prefix
  resource_group_id       = module.resource_group.ibm_resource_group_id
}

module "public_gateway" {
  source = "../../ibm_is/public_gateway"
  public_gateway_name = "pg-${var.suffix}"
  vpc_id              = module.vpc.vpc_id
  zone                = var.zone
  resource_group_id   = module.resource_group.ibm_resource_group_id
}

module "bastion_subnet" {
  source = "../../ibm_is/subnet"

  subnet_name = "bastion-subnet-${var.suffix}"
  ipv4_cidr_block = var.bastion_ipv4_cidr
  resource_group_id = module.resource_group.ibm_resource_group_id
  vpc_id = module.vpc.vpc_id
  zone = var.zone
  subnet_depends_on    = module.vpc.vpc_address_prefix_ids
  public_gateway_id = module.public_gateway.public_gateway_id
}

module "worker_subnet" {
  source = "../../ibm_is/subnet"

  subnet_name           = "worker-subnet-${var.suffix}"
  ipv4_cidr_block       = var.worker_ipv4_cidr
  resource_group_id     = module.resource_group.ibm_resource_group_id
  vpc_id                = module.vpc.vpc_id
  zone                  = var.zone
  subnet_depends_on     = module.vpc.vpc_address_prefix_ids
}

###### Bastion Security Group #########
module "security_group_bastion" {
  source = "../../ibm_is/security_group"

  sg_name           = "sg-bastion-${var.suffix}"
  vpc_id            = module.vpc.vpc_id
  resource_group_id = module.resource_group.ibm_resource_group_id
}

resource "ibm_is_security_group_rule" "sg_bastion_ssh_rule" {
  depends_on = [module.bastion_fip]
  group      = module.security_group_bastion.security_group_id
  direction  = "inbound"
  remote     = "0.0.0.0/0"

  tcp {
    port_min = 22
    port_max = 22
  }
}

resource "ibm_is_security_group_rule" "sg_bastion_icmp_rule" {
  depends_on = [module.bastion_fip]
  group      = module.security_group_bastion.security_group_id
  direction  = "inbound"
  remote     = "0.0.0.0/0"

  icmp {
    code  = 0
    type  = 8
  }
}

###### Worker Security Group #########
module "security_group_worker" {
  source = "../../ibm_is/security_group"

  sg_name           = "sg-worker-${var.suffix}"
  vpc_id            = module.vpc.vpc_id
  resource_group_id = module.resource_group.ibm_resource_group_id
}

resource "ibm_is_security_group_rule" "sg_worker_ssh_rule" {
  depends_on = [module.worker_subnet]
  group      = module.security_group_worker.security_group_id
  direction  = "inbound"
  remote     = module.security_group_bastion.security_group_id

  tcp {
    port_min = 22
    port_max = 22
  }
}

######## Instances ###########
resource "ibm_is_instance" "bastion" {
  name      = "bastion-${var.suffix}"
  image     = var.ubuntu_image
  profile   = var.profile
  vpc       = module.vpc.vpc_id
  zone      = var.zone
  keys      = [data.ibm_is_ssh_key.public_ssh_key.id]

  primary_network_interface {
    subnet = module.bastion_subnet.subnet_id
    security_groups   = [module.security_group_bastion.security_group_id]
  }
}

resource "null_resource" "ssh_bastion_check" {
  triggers = {
    bastion_instance_id = ibm_is_instance.bastion.id
  }

  connection {
    type = "ssh"
    user = "ubuntu"
    host = module.bastion_fip.floating_ip.address
    private_key = local.ssh_private_key
    timeout = "5m"
  }

  provisioner "remote-exec" {
    inline = ["echo $(uname -a)"]
  }
}

######## Worker Instance ###########
resource "ibm_is_instance" "ubuntu_worker" {
  name      = "ubuntu-worker-${var.suffix}"
  image     = var.ubuntu_image
  profile   = var.profile
  vpc       = module.vpc.vpc_id
  zone      = var.zone
  keys      = [data.ibm_is_ssh_key.public_ssh_key.id]

  primary_network_interface {
    subnet = module.worker_subnet.subnet_id
    security_groups   = [module.security_group_worker.security_group_id]
  }

}
