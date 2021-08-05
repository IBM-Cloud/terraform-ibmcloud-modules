

variable "region" {
  description = "Region name"
  default     = "us-south"
}

data "ibm_is_zones" "this" {
    region = var.region
}

output "zones" {
  value = data.ibm_is_zones.this
}
