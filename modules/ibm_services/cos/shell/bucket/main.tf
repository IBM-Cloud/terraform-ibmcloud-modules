# IBM Confidential
# OCO Source Materials
# CLD-68685-1602740467
# (c) Copyright IBM Corp. 2020
# The source code for this program is not published or otherwise
# divested of its trade secrets, irrespective of what has been
# deposited with the U.S. Copyright Office.


variable regions_endpoint {}
variable region {}
variable bucket_name {}
variable cos_instance_id {}
variable storage_class {}
variable resource_group_id {}

resource "shell_script" "cos_bucket" {
  lifecycle_commands {
    create = file("${path.module}/scripts/create.sh")
    delete = file("${path.module}/scripts/delete.sh")
    read   = file("${path.module}/scripts/read.sh")
  }
 
  environment = {
    REGIONS_ENDPOINT  = var.regions_endpoint
    REGION            = var.region
    NAME              = var.bucket_name
    COS_INSTANCE_ID   = var.cos_instance_id
    STORAGE_CLASS     = var.storage_class
    RESOURCE_GROUP_ID = var.resource_group_id
  }
}

output "cos_bucket" {
  value = shell_script.cos_bucket.output
}
