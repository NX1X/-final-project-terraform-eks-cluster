resource "aws_eks_cluster" "eks_cluster" {
  name     = "eks-cluster"
  role_arn = var.cluster_role_arn

  vpc_config {
    subnet_ids         = var.subnet_ids
    security_group_ids = var.security_group_ids
  }

  depends_on = [var.cluster_role_arn]
}

resource "aws_launch_template" "eks_nodes" {
  name = "eks-node-group-template-${random_string.suffix.result}"

  block_device_mappings {
    device_name = "/dev/xvda"

    ebs {
      volume_size = var.node_group_config.disk_size
      volume_type = "gp3"
      encrypted   = true
    }
  }

  instance_type = var.node_group_config.instance_type
  key_name      = var.ec2_ssh_key_name

  network_interfaces {
    associate_public_ip_address = true
    security_groups             = var.security_group_ids
  }

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "EKS-${aws_eks_cluster.eks_cluster.name}-node"
    }
  }

  user_data = base64encode(<<-EOF
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="==BOUNDARY=="

--==BOUNDARY==
Content-Type: text/x-shellscript; charset="us-ascii"

#!/bin/bash
set -ex
/etc/eks/bootstrap.sh ${aws_eks_cluster.eks_cluster.name}

--==BOUNDARY==--
EOF
  )

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_eks_node_group" "eks_node_group" {
  cluster_name    = aws_eks_cluster.eks_cluster.name
  node_group_name = "eks-node-group-${random_string.suffix.result}"
  node_role_arn   = var.node_group_role_arn
  subnet_ids      = var.subnet_ids

  scaling_config {
    desired_size = var.node_group_config.desired_size
    max_size     = var.node_group_config.max_size
    min_size     = var.node_group_config.min_size
  }

  launch_template {
    id      = aws_launch_template.eks_nodes.id
    version = "$Latest"
  }

  depends_on = [var.node_group_role_arn]

  lifecycle {
    create_before_destroy = true
  }
}

resource "random_string" "suffix" {
  length  = 8
  special = false
}