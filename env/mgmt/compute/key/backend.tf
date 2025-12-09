terraform {
  backend "s3" {
    bucket = "transbnk-devops-tf-state"
    key    = "env/devops/compute/key/key.tfstate"
    region = "ap-south-1"
  }
}