terraform {
  required_version = ">=0.12, <0.15"
  required_providers {
    ibm = {
      source  = "ibm-cloud/ibm"
      version = ">=1.17.0"
    }
    shell = {
      source  = "scottwinkler/shell"
      version = ">=1.7.7"
    }
  }
}
