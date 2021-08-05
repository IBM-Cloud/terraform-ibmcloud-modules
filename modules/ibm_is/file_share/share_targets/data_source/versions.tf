

terraform {
  required_version = ">=0.13"
  required_providers {
    ibm = {
      source  = "local/ibm-cloud/ibm"
      version = ">=1.20.1"
    }
    shell = {
      source = "scottwinkler/shell"
      version = ">=1.7.7"
    }
    random = {
      source = "hashicorp/random"
      version = ">=3.0.1"
    }
  }
}
