terraform {
  required_version = ">=0.14"
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
