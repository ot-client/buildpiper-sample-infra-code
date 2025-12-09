region               = "ap-south-1"
key_name             = "transbnk-devops"
instance_count       = 1
ami_id               = "ami-027c694fe847798f5"
instance_type        = "c5a.2xlarge"
public_ip            = false
volume_size          = 200
volume_type          = "gp3"
encrypted_volume     = false
iam_instance_profile = "BPEC2ADMINACCESS"
ec2_name             = "transbnk-devops-Buildpiper"
sg_name              = "transbnk-devops-Buildpiper-SG"

