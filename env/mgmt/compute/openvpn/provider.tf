provider "aws" {
  region = var.region
  default_tags {
    tags = {
      "owner"      = "devops"
      "env"        = "devops"
      "managed-by" = "terraform"

    }
  }
}