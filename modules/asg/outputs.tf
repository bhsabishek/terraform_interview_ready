output "autoscaling_group_name" {
    description = "The name of the Auto Scaling Group."
    value       = aws_autoscaling_group.this.name   
}

output "launch_template_id" {
    description = "The ID of the Launch Template."
    value       = aws_launch_template.this.id
}

output "launch_template_version" {
    description = "The version of the Launch Template."
    value       = aws_launch_template.this.latest_version
}

output "autoscaling_group_arn" {
    description = "The ARN of the Auto Scaling Group."
    value       = aws_autoscaling_group.this.arn
}