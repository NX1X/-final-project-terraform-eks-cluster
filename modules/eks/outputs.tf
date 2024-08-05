# modules/eks/outputs.tf
output "endpoint" {
  value = aws_eks_cluster.eks_cluster.endpoint
}

output "kubeconfig-certificate-authority-data" {
  value = aws_eks_cluster.eks_cluster.certificate_authority[0].data
}

output "cluster_name" {
  value = aws_eks_cluster.eks_cluster.name
}

output "cluster_id" {
  value = aws_eks_cluster.eks_cluster.id
}

output "kubectl_command" {
  description = "kubectl command to update kubeconfig"
  value       = "aws eks --region ${data.aws_region.current.name} update-kubeconfig --name ${aws_eks_cluster.eks_cluster.name}"
}

data "aws_region" "current" {}

