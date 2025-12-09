terraform {
  backend "s3" {
    bucket = "transbnk-dev-tf-state"
    key    = "env/dev/compute/middleware/key.tfstate"
    region = "ap-south-1"
  }
}