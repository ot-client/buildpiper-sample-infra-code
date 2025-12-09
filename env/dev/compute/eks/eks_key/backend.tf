terraform {
  backend "s3" {
    bucket = "transbnk-dev-tf-state"
    key    = "env/dev/compute/key/key.tfstate"
    region = "ap-south-1"
  }
}