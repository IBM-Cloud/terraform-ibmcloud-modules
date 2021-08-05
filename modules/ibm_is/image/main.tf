# IBM Confidential
# OCO Source Materials
# CLD-68685-1602740447
# (c) Copyright IBM Corp. 2020
# The source code for this program is not published or otherwise
# divested of its trade secrets, irrespective of what has been
# deposited with the U.S. Copyright Office.


variable "image_name" {
  description = " VSI image name"
  default     = "ibm-ubuntu-18-04-1-minimal-amd64-1"
}

variable "visibility" {
  description = "VSI image visibility"
  default     = "public"
}

data "ibm_is_image" "this"{
  name       = var.image_name
  visibility = var.visibility
}

output "image" {
  value = data.ibm_is_image.this
}

output "image_id" {
  value = data.ibm_is_image.this.id
}
