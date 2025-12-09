locals {
  common_tags                   = {}
  worker_group1_tags            = { "Name" : "dev-app-NG" }
  worker_group2_tags            = { "Name" : "qa-app-NG" }
  worker_group3_tags            = { "Name" : "demo-app-NG" }
  worker_group4_tags            = { "Name" : "sandbox-app-NG" }
  worker_group5_tags            = { "Name" : "db-NG" }
  worker_group6_tags            = { "Name" : "o11y-NG" }


  cluster_endpoint_access_cidrs = [""]
  vpc_id                        = data.terraform_remote_state.network.outputs.vpc_id
  subnet_ids                    = [data.terraform_remote_state.network.outputs.app_subnet_ids[0][0], data.terraform_remote_state.network.outputs.app_subnet_ids[0][1], data.terraform_remote_state.network.outputs.app_subnet_ids[0][2], data.terraform_remote_state.network.outputs.db_middleware_subnet_ids[0][0], data.terraform_remote_state.network.outputs.db_middleware_subnet_ids[0][1]]
  w1_subnet_ids                 = [data.terraform_remote_state.network.outputs.app_subnet_ids[0][0], data.terraform_remote_state.network.outputs.app_subnet_ids[0][1]]
  w2_subnet_ids                 = [data.terraform_remote_state.network.outputs.app_subnet_ids[0][0]]
  w3_subnet_ids                 = [data.terraform_remote_state.network.outputs.app_subnet_ids[0][0]]
  w4_subnet_ids                 = [data.terraform_remote_state.network.outputs.app_subnet_ids[0][0]]
  w5_subnet_ids                 = [data.terraform_remote_state.network.outputs.db_middleware_subnet_ids[0][0]]
  w6_subnet_ids                 = [data.terraform_remote_state.network.outputs.db_middleware_subnet_ids[0][1]]
}
module "eks_internal_ssh_security_group" {
  #checkov:skip=CKV_TF_1:Ensure Terraform module sources use a commit hash
  source                             = "OT-CLOUD-KIT/security-groups/aws"
  version                            = "1.0.0"
  enable_whitelist_ip                = true
  enable_source_security_group_entry = true
  name_sg                            = var.eks_node_sg_name
  vpc_id                             = local.vpc_id
  ingress_rule = {
    rules = {
      rule_list = [
        {
          description  = "22 port for mgmt vpn private ip "
          from_port    = 22
          to_port      = 22
          protocol     = "tcp"
          cidr         = [""]
          ipv6_cidr    = []
          source_SG_ID = []
        }
      ]
    }
  }
}

module "dev_eks_cluster" {
  #checkov:skip=CKV_TF_1:Ensure Terraform module sources use a commit hash
  source                        = "OT-CLOUD-KIT/eks/aws"
  version                       = "1.1.0"
  cluster_name                  = var.cluster_name
  eks_cluster_version           = var.eks_cluster_version
  subnets                       = local.subnet_ids
  tags                          = local.common_tags
  kubeconfig_name               = "config"
  config_output_path            = "config"
  eks_node_group_name           = var.eks_node_group_name
  region                        = var.region
  cluster_endpoint_whitelist    = true
  cluster_endpoint_access_cidrs = local.cluster_endpoint_access_cidrs
  create_node_group             = true
  endpoint_private              = true
  endpoint_public               = false
  k8s-spot-termination-handler  = false
  cluster_autoscaler            = false
  metrics_server                = false
  vpc_id                        = local.vpc_id
  slackUrl                      = "slack_webhook_url"
  node_groups = {
    "dev-app-NG" = {
      subnets            = local.w1_subnet_ids
      ssh_key            = var.ssh_key
      security_group_ids = [module.eks_internal_ssh_security_group.sg_id]
      instance_type      = var.w1_instance_type
      ami_type           = var.ami_type
      desired_capacity   = var.w1_desired_capacity
      disk_size          = var.w1_disk_size
      max_capacity       = var.w1_max_capacity
      min_capacity       = var.w1_min_capacity
      capacity_type      = var.w1_capacity_type
      tags               = merge(local.common_tags, local.worker_group1_tags)
      labels             = { "TYPE" : "SPOT", "node_group" : "dev-app", "PROJECT" : "BUILDPIPER" }
    }
    "qa-app-NG" = {
      subnets            = local.w2_subnet_ids
      ssh_key            = var.ssh_key
      security_group_ids = [module.eks_internal_ssh_security_group.sg_id]
      instance_type      = var.w2_instance_type
      ami_type           = var.ami_type
      desired_capacity   = var.w2_desired_capacity
      disk_size          = var.w2_disk_size
      max_capacity       = var.w2_max_capacity
      min_capacity       = var.w2_min_capacity
      capacity_type      = var.w2_capacity_type
      tags               = merge(local.common_tags, local.worker_group2_tags)
      labels             = { "TYPE" : "SPOT", "node_group" : "qa-app", "PROJECT" : "BUILDPIPER" }
    }

    "demo-app-NG" = {
      subnets            = local.w3_subnet_ids
      ssh_key            = var.ssh_key
      security_group_ids = [module.eks_internal_ssh_security_group.sg_id]
      instance_type      = var.w3_instance_type
      ami_type           = var.ami_type
      desired_capacity   = var.w3_desired_capacity
      disk_size          = var.w3_disk_size
      max_capacity       = var.w3_max_capacity
      min_capacity       = var.w3_min_capacity
      capacity_type      = var.w3_capacity_type
      tags               = merge(local.common_tags, local.worker_group3_tags)
      labels             = { "TYPE" : "SPOT", "node_group" : "demo-app", "PROJECT" : "BUILDPIPER" }
    }

    "sandbox-app-NG" = {
      subnets            = local.w4_subnet_ids
      ssh_key            = var.ssh_key
      security_group_ids = [module.eks_internal_ssh_security_group.sg_id]
      instance_type      = var.w4_instance_type
      ami_type           = var.ami_type
      desired_capacity   = var.w4_desired_capacity
      disk_size          = var.w4_disk_size
      max_capacity       = var.w4_max_capacity
      min_capacity       = var.w4_min_capacity
      capacity_type      = var.w4_capacity_type
      tags               = merge(local.common_tags, local.worker_group4_tags)
      labels             = { "TYPE" : "SPOT", "node_group" : "sandbox-app", "PROJECT" : "BUILDPIPER" }
    }
    "db-app-NG" = {
      subnets            = local.w5_subnet_ids
      ssh_key            = var.ssh_key
      security_group_ids = [module.eks_internal_ssh_security_group.sg_id]
      instance_type      = var.w5_instance_type
      ami_type           = var.ami_type
      desired_capacity   = var.w5_desired_capacity
      disk_size          = var.w5_disk_size
      max_capacity       = var.w5_max_capacity
      min_capacity       = var.w5_min_capacity
      capacity_type      = var.w5_capacity_type
      tags               = merge(local.common_tags, local.worker_group5_tags)
      labels             = { "TYPE" : "ON-DEMAND", "node_group" : "db-app", "PROJECT" : "BUILDPIPER" }
    }
    "o11y-app-NG" = {
      subnets            = local.w6_subnet_ids
      ssh_key            = var.ssh_key
      security_group_ids = [module.eks_internal_ssh_security_group.sg_id]
      instance_type      = var.w6_instance_type
      ami_type           = var.ami_type
      desired_capacity   = var.w6_desired_capacity
      disk_size          = var.w6_disk_size
      max_capacity       = var.w6_max_capacity
      min_capacity       = var.w6_min_capacity
      capacity_type      = var.w6_capacity_type
      tags               = merge(local.common_tags, local.worker_group6_tags)
      labels             = { "TYPE" : "ON-DEMAND", "node_group" : "o11y-app", "PROJECT" : "BUILDPIPER" }
    }
  }
}
