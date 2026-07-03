output "name" {
  value = aws_alb.this.name
}

output "arn" {
  value = aws_alb.this.arn
}

output "dns_name" {
  value = aws_alb.this.dns_name
}

output "zone_id" {
  value = aws_alb.this.zone_id
}

output "target_group_arn" {
  value = aws_alb_target_group.this.arn
}

output "listener_arn" {
  value = aws_alb_listener.this.arn
}

output "vpc_id" {
  value = aws_alb.this.vpc_id
}

output "security_groups" {
  value = aws_alb.this.security_groups
}

output "target_group_attachment_id" {
  value = aws_alb_target_group_attachment.this.id
}