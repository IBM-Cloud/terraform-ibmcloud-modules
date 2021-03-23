#########1#########2#########3#########4#########5#########6#########7#########8
# Resources
#########1#########2#########3#########4#########5#########6#########7#########8
data ibm_resource_group "this" {
    name = var.resource_group_name
}

resource ibm_is_public_gateway "this" {
    vpc  = var.vpc_id
    zone = var.zone
    name = var.public_gateway_name
}
