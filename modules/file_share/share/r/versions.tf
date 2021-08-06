
terraform {
  required_version = ">=0.13"
  required_providers {
    ibm = {
      source  = "local/ibm-cloud/ibm"
      version = "=1.24.0-shares"
    }
  }
}
