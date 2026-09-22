# ========================================
# VPC Outputs
# ========================================

output "vpc_id" {
  description = "VPC ID"
  value       = aws_vpc.main.id
}

output "vpc_cidr" {
  description = "VPC CIDR"
  value       = aws_vpc.main.cidr_block
}


# ========================================
# Subnet Outputs
# ========================================

output "public_subnet_id" {
  description = "Public Subnet ID"
  value       = aws_subnet.public.id
}


# ========================================
# Internet Gateway
# ========================================

output "internet_gateway_id" {
  description = "Internet Gateway ID"
  value       = aws_internet_gateway.main.id
}


# ========================================
# Route Table
# ========================================

output "route_table_id" {
  description = "Public Route Table ID"
  value       = aws_route_table.public.id
}


# ========================================
# EC2 Outputs
# ========================================

output "ec2_instance_id" {
  description = "EC2 Instance ID"
  value       = aws_instance.web.id
}

output "ec2_public_ip" {
  description = "EC2 Public IP"
  value       = aws_instance.web.public_ip
}

output "ec2_private_ip" {
  description = "EC2 Private IP"
  value       = aws_instance.web.private_ip
}

output "ec2_public_dns" {
  description = "EC2 Public DNS"
  value       = aws_instance.web.public_dns
}


# ========================================
# IAM Outputs
# ========================================

output "iam_role_name" {
  description = "IAM Role Name"
  value       = data.aws_iam_role.iam_1.name
}

output "iam_role_arn" {
  description = "IAM Role ARN"
  value       = data.aws_iam_role.iam_1.arn
}

output "instance_profile_name" {
  description = "Instance Profile Name"
  value       = aws_iam_instance_profile.iam_1.name
}