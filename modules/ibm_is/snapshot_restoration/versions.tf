

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

