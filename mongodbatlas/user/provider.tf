terraform {
  required_version = ">= 1.0.0"
  required_providers {
    aws = {}
    mongodbatlas = {
      source = "mongodb/mongodbatlas"
      configuration_aliases = [ mongodbatlas.creds ]
    }
  }
}