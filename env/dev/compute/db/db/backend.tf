terraform {
  backend "s3" {
    bucket = "transbnk-dev-tf-state"
    key    = "env/dev/compute/db/db-ec2.tfstate"
    region = "ap-south-1"
  }
}

