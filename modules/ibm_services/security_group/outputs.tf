# IBM Confidential
# OCO Source Materials
# CLD-68685-1602740498
# (c) Copyright IBM Corp. 2020
# The source code for this program is not published or otherwise
# divested of its trade secrets, irrespective of what has been
# deposited with the U.S. Copyright Office.


output "id" {
  value = ibm_is_security_group.sg[*].id
}
