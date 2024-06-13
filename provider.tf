provider "mongodbatlas" {
  public_key  = var.public_key
  private_key = var.private_key
}

terraform {
  required_version = ">= 1.0.5"
  required_providers {
    mongodbatlas = {
      source = "mongodb/mongodbatlas"
    }
  }
}
