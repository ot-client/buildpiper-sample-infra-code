region           = "ap-south-1"
key_name         = "dev-db-key"
instance_count   = 1
ami_id           = "ami-0be59543e9e8897d7"
instance_type    = "r5.xlarge"
public_ip        = false
volume_size      = 300
volume_type      = "gp3"
encrypted_volume = true
ec2_name         = "transbnk-dev-db"
sg_name          = "transbnk-dev-db-sg"

