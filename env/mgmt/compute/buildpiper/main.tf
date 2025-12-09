module "ec2_instance" {
  source               = "OT-CLOUD-KIT/ec2-instance/aws"
  version              = "0.0.3"
  count                = var.instance_count
  ami_id               = var.ami_id
  instance_type        = var.instance_type
  public_ip            = var.public_ip
  key_name             = var.key_name
  subnet               = data.terraform_remote_state.network.outputs.pvt_subnet_ids[0][0]
  security_groups      = [module.buildpiper_security_group.sg_id]
  volume_size          = var.volume_size
  volume_type          = var.volume_type
  encrypted_volume     = var.encrypted_volume
  iam_instance_profile = var.iam_instance_profile
  ec2_name             = var.ec2_name
  tags                 = var.tags
}
module "buildpiper_security_group" {
  source                              = "OT-CLOUD-KIT/security-groups/aws"
  version                             = "1.0.0"
  name_sg                             = var.sg_name
  tags                                = var.tags
  enable_whitelist_ip                 = true
  enable_source_security_group_entry  = true
  create_outbound_rule_with_src_sg_id = false

  vpc_id = data.terraform_remote_state.network.outputs.vpc_id
  ingress_rule = {
    rules = {
      rule_list = [
        {
          description  = "Allow port 22 for ssh from devops vpn sg"
          from_port    = 22
          to_port      = 22
          protocol     = "tcp"
          cidr         = []
          source_SG_ID = [data.terraform_remote_state.openvpn.outputs.vpn_sg_id]
        },
        {
          description  = "Allow port 80 for devops vpn sg"
          from_port    = 80
          to_port      = 80
          protocol     = "tcp"
          cidr         = []
          source_SG_ID = [data.terraform_remote_state.openvpn.outputs.vpn_sg_id]
        },
      ]
    }
  }
}

