# IBM Confidential
# OCO Source Materials
# CLD-88676-1620634890
# (c) Copyright IBM Corp. 2021
# The source code for this program is not published or otherwise
# divested of its trade secrets, irrespective of what has been
# deposited with the U.S. Copyright Office


terraform {
  required_version = ">=0.13"
  required_providers {
    shell = {
      source = "scottwinkler/shell"
      version = ">=1.7.7"
    }
  }
}

provider "shell" {
  interpreter = ["/bin/bash", "-c"]
  enable_parallelism = false
}

