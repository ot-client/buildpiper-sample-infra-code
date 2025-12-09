terraform {
  backend "s3" {
    bucket         = "transbnk-dev-tf-state"
    key            = "env/dev/compute/eks.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "terraform-state-locking"
  }
}