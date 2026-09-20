output "instance_id" {
  description = "EC2 instance ID"
  value       = aws_instance.ec2.id
}

output "instance_public_ip" {
  description = "EC2 public IP"
  value       = aws_instance.ec2.public_ip
}

output "iam_role_name" {
  description = "IAM role name"
  value       = aws_iam_role.ec2_role.name
}

output "instance_profile_name" {
  description = "IAM instance profile name"
  value       = aws_iam_instance_profile.ec2_profile.name
}