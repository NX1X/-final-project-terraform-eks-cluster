# AWS EKS Ready-to-Install Module

## Overview

This Terraform module provisions a production-ready Amazon Elastic Kubernetes Service (EKS) cluster. It sets up the necessary infrastructure components including VPC, subnets, security groups, and IAM roles, providing a solid foundation for deploying and managing containerized applications on AWS.

## Features

- Creates a new VPC optimized for EKS
- Sets up both internal and external security groups
- Configures public and private subnets across multiple Availability Zones
- Establishes necessary IAM roles and policies
- Provisions an EKS cluster with configurable node groups

## Prerequisites

- AWS CLI configured with appropriate credentials
- Terraform v0.12+
- kubectl installed (for cluster management post-deployment)

## Module Components

### VPC
- Creates a new VPC with specified CIDR block
- Sets up Internet Gateway for public subnets
- Configures NAT Gateways for private subnets

### Subnets
- Creates public and private subnets across multiple AZs
- Configures route tables for each subnet type

### Security Groups
- External: Allows inbound traffic on ports 80 and 443
- Internal: Permits all traffic within the VPC

### IAM
- Creates IAM roles for EKS cluster and node groups
- Attaches necessary policies for EKS operation

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| cluster_name | Name of the EKS cluster | string | n/a | yes |
| vpc_cidr | CIDR block for the VPC | string | "10.0.0.0/16" | no |
| region | AWS region to deploy the cluster | string | n/a | yes |
| instance_types | List of EC2 instance types for the node groups | list(string) | ["t3.medium"] | no |
| desired_capacity | Desired number of worker nodes | number | 2 | no |
| max_size | Maximum number of worker nodes | number | 5 | no |
| min_size | Minimum number of worker nodes | number | 1 | no |

## Outputs

| Name | Description |
|------|-------------|
| cluster_endpoint | Endpoint for your Kubernetes API server |
| cluster_name | Name of the EKS cluster |
| vpc_id | ID of the VPC created for EKS |

## Post-Deployment

After applying the Terraform configuration, you can configure kubectl to interact with your new cluster:

```bash
aws eks --region <your-region> update-kubeconfig --name <your-cluster-name>
```

## Contributing

Contributions to improve the module are welcome. Please follow these steps:

1. Fork the repository
2. Create a feature branch
3. Commit your changes
4. Push to the branch
5. Create a new Pull Request

## License

This module is released under the MIT License. See the LICENSE file for details.
