variable "ec2_ssh_key_name" {
  description = "Name of the EC2 key pair to use for SSH access"
  type        = string
}

# ... other variables ...

variable "node_group_config" {
  description = "Configuration for the EKS node group"
  type = object({
    desired_size = number
    max_size     = number
    min_size     = number
    instance_type = string
    disk_size     = number
  })
}