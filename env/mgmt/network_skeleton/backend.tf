terraform {
  backend "s3" {
    bucket = "transbnk-devops-tf-state"
    key    = "env/devops/network-skeleton/network.tfstate"
    region = "ap-south-1"

    dynamodb_table = "terraform-state-locking"
    encrypt        = true
  }
}
