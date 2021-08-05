# IBM Confidential
# OCO Source Materials
# CLD-68685-1602740452
# (c) Copyright IBM Corp. 2020
# The source code for this program is not published or otherwise
# divested of its trade secrets, irrespective of what has been
# deposited with the U.S. Copyright Office.


output "instances" {
  value = ibm_is_instance.this
}

output "instance_ids" {
  value = [for instance in ibm_is_instance.this: instance.id]
}
