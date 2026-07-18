variable "ami_id" {
  description = "The AMI ID to use for the EC2 instance."
  type        = string
}

variable "instance_type" {
  description = "The instance type for the EC2 instance."
  type        = string
}

variable "security_group_ids" {
  description = "The security group IDs for the EC2 instance."
  type        = list(string)
}

/*
variable "key_name" {
  description = "The key pair name for the EC2 instance."
  type        = string
}
*/

variable "environment" {
  description = "The environment (e.g., dev, prod)."
  type        = string
}

variable "lt_name_prefix" {
  description = "The name prefix for the launch template."
  type        = string
}

variable "subnet_ids" {
  description = "The subnet IDs for the Auto Scaling Group."
  type        = list(string)
}

variable "alb_target_group_arn" {
  description = "The ARN of the ALB target group."
  type        = string
}

variable "instance_name" {
  description = "The name for the EC2 instances in the Auto Scaling Group."
  type        = string
}

variable "iam_instance_profile_name" {
  description = "instance profile name"
  type        = string
}