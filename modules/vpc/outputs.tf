# modules/vpc/outputs.tf
output "vpc_id" {
  value = aws_vpc.eks_vpc.id
}

output "subnet_ids" {
  value = [aws_subnet.eks_subnet_1.id, aws_subnet.eks_subnet_2.id, aws_subnet.eks_subnet_3.id]
}