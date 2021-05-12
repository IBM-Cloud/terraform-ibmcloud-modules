

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
