# terraform/outputs.tf

output "example_instance_public_ip" {
  description = "The public IP address of the example instance"
  value       = aws_instance.example.public_ip
  sensitive   = false
}

output "example_instance_private_ip" {
  description = "The private IP address of the example instance"
  value       = aws_instance.example.private_ip
  sensitive   = false
}

output "example_instance_id" {
  description = "The ID of the example instance"
  value       = aws_instance.example.id
  sensitive   = false
}

output "example_instance_availability_zone" {
  description = "The availability zone of the example instance"
  value       = aws_instance.example.availability_zone
  sensitive   = false
}

output "example_instance_security_groups" {
  description = "The security groups associated with the example instance"
  value       = aws_instance.example.security_groups
  sensitive   = false
}