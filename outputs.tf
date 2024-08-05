# outputs.tf
output "eks_endpoint" {
  value = module.eks.endpoint
}

output "eks_kubeconfig_certificate_authority_data" {
  value = module.eks.kubeconfig-certificate-authority-data
}

output "kubectl_command" {
  description = "kubectl command to update kubeconfig"
  value       = module.eks.kubectl_command
}
