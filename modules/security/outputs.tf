output "eks_external_sg_id" {
  value = aws_security_group.eks_external_sg.id
}

output "eks_internal_sg_id" {
  value = aws_security_group.eks_internal_sg.id
}