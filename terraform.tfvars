ec2_ssh_key_name = "you-key-pair-name"

node_group_config = {
  desired_size = 2
  max_size     = 4
  min_size     = 2
  instance_type = "t3.2xlarge"  # Changed to t3.2xlarge
  disk_size     = 200  # Assuming you want to keep the 200GB disk size
}

# ... other variable values ...