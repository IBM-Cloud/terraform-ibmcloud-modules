# IBM Confidential
# OCO Source Materials
# CLD-89794-1624481893
# (c) Copyright IBM Corp. 2021
# The source code for this program is not published or otherwise
# divested of its trade secrets, irrespective of what has been
# deposited with the U.S. Copyright Office


terraform {
  required_version = ">=0.12"
  required_providers {
    ibm = {
      source  = "ibm-cloud/ibm"
      version = ">=1.23.2"
    }
    shell = {
      source  = "scottwinkler/shell"
      version = ">=1.7.7"
    }
  }
}
