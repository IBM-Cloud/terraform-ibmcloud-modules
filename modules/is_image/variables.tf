variable "name" {
  description = " VSI image name"
}

variable "visibility" {
  description = "VSI image visibility"
  default     = "public"
}

variable "href" {
  description = "The path of an image to be uploaded"
}

variable "operating_system" {
  description = "Description of underlying OS of an image"
}
