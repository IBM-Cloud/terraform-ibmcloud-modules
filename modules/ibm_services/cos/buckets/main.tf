

variable "bucket_count" {
  description = "The number of cloud object store buckets"
  type        = number
  default     = 1
}

variable "bucket_name" {
  description = "COS bucket name"
}

variable "cos_instance_guid" {
  description = "Cloud object store instance guid"
}

variable "region_location" {
  description = "COS bucket region location"
  type        = string
  default     = "us-south"

}

variable "storage_class" {
  description = "COS bucket storage class"
  type        = string
  default     = "standard"
}

resource "ibm_cos_bucket" "this" {
  count                 = var.bucket_count
  bucket_name           = "${var.bucket_name}-${count.index}"
  resource_instance_id  = var.cos_instance_guid
  region_location       = var.region_location
  storage_class         = var.storage_class
}

output "cos_buckets" {
  value = ibm_cos_bucket.this
}

output "cos_bucket_ids" {
  value = [for item in ibm_cos_bucket.this: item.id]
}
