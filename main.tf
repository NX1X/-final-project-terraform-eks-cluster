# main.tf
provider "aws" {
  region = "eu-north-1"
}

module "vpc" {
  source = "./modules/vpc"
}

module "security" {
  source = "./modules/security"
  vpc_id = module.vpc.vpc_id
}

module "eks" {
  source               = "./modules/eks"
  vpc_id               = module.vpc.vpc_id
  subnet_ids           = module.vpc.subnet_ids
  security_group_ids   = [module.security.eks_external_sg_id, module.security.eks_internal_sg_id]
  cluster_role_arn     = module.iam.eks_cluster_role_arn
  node_group_role_arn  = module.iam.eks_node_group_role_arn
  ec2_ssh_key_name     = var.ec2_ssh_key_name
  node_group_config    = var.node_group_config
}


module "iam" {
  source = "./modules/iam"
}

