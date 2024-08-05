variable "vpc_id" {
  description = "ID of the VPC"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs"
  type        = list(string)
}

variable "security_group_ids" {
  description = "List of security group IDs for the EKS cluster"
  type        = list(string)
}

variable "cluster_role_arn" {
  description = "ARN of the EKS cluster IAM role"
  type        = string
}

variable "node_group_role_arn" {
  description = "ARN of the EKS node group IAM role"
  type        = string
}

variable "ec2_ssh_key_name" {
  description = "Name of the EC2 key pair to use for SSH access"
  type        = string
}

variable "node_group_config" {
  description = "Configuration for the EKS node group"
  type = object({
    desired_size  = number
    max_size      = number
    min_size      = number
    instance_type = string
    disk_size     = number
  })
}