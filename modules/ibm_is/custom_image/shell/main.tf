# IBM Confidential
# OCO Source Materials
# CLD-68685-1602740432
# (c) Copyright IBM Corp. 2020
# The source code for this program is not published or otherwise
# divested of its trade secrets, irrespective of what has been
# deposited with the U.S. Copyright Office.


variable region {}
variable image_name {}
variable image_file {}
variable os_name {}
variable encrypted_data_key {}
variable encryption_key {}
variable resource_group_id {}
variable ci_depends_on {}

resource "shell_script" "custom_image" {
  lifecycle_commands {
    create = file("${path.module}/scripts/create.sh")
    delete = file("${path.module}/scripts/delete.sh")
    read   = file("${path.module}/scripts/read.sh")
  }
 
  environment = {
    REGION             = var.region
    IMAGE_NAME         = var.image_name
    IMAGE_FILE         = var.image_file
    OS_NAME            = var.os_name
    ENCRYPTED_DATA_KEY = var.encrypted_data_key
    ENCRYPTION_KEY     = var.encryption_key
    RESOURCE_GROUP_ID  = var.resource_group_id
  }
  
  depends_on = [var.ci_depends_on,]

}

output "custom_image" {
  value = shell_script.custom_image.output
}
