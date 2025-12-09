data "terraform_remote_state" "network" {
  backend = "s3"
  config = {
    bucket = "transbnk-devops-tf-state"
    key    = "env/devops/network-skeleton/network.tfstate"
    region = "ap-south-1"
  }
}

data "terraform_remote_state" "openvpn" {
  backend = "s3"
  config = {
    bucket = "transbnk-devops-tf-state"
    key    = "env/devops/compute/openvpn/openvpn.tfstate"
    region = "ap-south-1"
  }
}
