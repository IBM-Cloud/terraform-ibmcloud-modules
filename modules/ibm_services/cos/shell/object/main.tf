

variable regions_endpoint {}
variable region {}
variable bucket_name {}
variable key {}
variable passphrase {}
variable base_image_file_url {}
variable base_image_file {}
variable resource_group_id {}

resource "shell_script" "object" {
  lifecycle_commands {
    create = file("${path.module}/scripts/create.sh")
    delete = file("${path.module}/scripts/delete.sh")
    read   = file("${path.module}/scripts/read.sh")
  }
 
  environment = {
    REGIONS_ENDPOINT    = var.regions_endpoint
    REGION              = var.region
    BUCKET_NAME         = var.bucket_name
    KEY                 = var.key
    PASSPHRASE          = var.passphrase 
    BASE_IMAGE_FILE_URL = var.base_image_file_url
    BASE_IMAGE_FILE     = var.base_image_file
    RESOURCE_GROUP_ID   = var.resource_group_id
  }
}

output "object" {
  value = shell_script.object.output
}
