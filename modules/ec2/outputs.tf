output "instance_id" {
    description = "The ID of the EC2 instance"
    value       = aws_instance.my_ec2.id
}

output "private_ip" {
    description = "The private IP address of the EC2 instance"
    value       = aws_instance.my_ec2.private_ip
}

output "public_ip" {
    description = "The public IP address of the EC2 instance"
    value       = aws_instance.my_ec2.public_ip
}

output "availability_zone" {
    description = "The availability zone of the EC2 instance"
    value       = aws_instance.my_ec2.availability_zone
}

output "arn" {
    description = "The ARN of the EC2 instance"
    value       = aws_instance.my_ec2.arn
}