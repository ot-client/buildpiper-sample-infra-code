region           = "ap-south-1"
key_name         = "dev-middleware-key"
instance_count   = 1
ami_id           = "ami-0be59543e9e8897d7"
instance_type    = "m5.2xlarge"
public_ip        = false
volume_size      = 200
volume_type      = "gp3"
encrypted_volume = true
ec2_name         = "transbnk-dev-middleware"
sg_name          = "transbnk-dev-middleware-sg"

