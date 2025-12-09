terraform {
  backend "s3" {
    bucket = "transbnk-devops-tf-state"
    key    = "env/devops/compute/buildpiper/buildpiper-ec2.tfstate"
    region = "ap-south-1"
  }
}

