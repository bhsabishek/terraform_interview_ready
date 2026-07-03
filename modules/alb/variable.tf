variable "name" {
  description = "The name of the ALB"
  type        = string
}

variable "internal" {
  description = "Boolean to indicate if the ALB is internal or internet-facing"
  type        = bool
  default     = false
}

variable "security_groups" {
  description = "List of security group IDs to associate with the ALB"
  type        = list(string)
}

variable "subnets" {
  description = "List of subnet IDs to attach to the ALB"
  type        = list(string)
}

variable "enable_deletion_protection" {
  description = "Boolean to enable deletion protection for the ALB"
  type        = bool
  default     = false
}

variable "vpc_id" {
  description = "The ID of the VPC where the ALB will be created"
  type        = string
}

/*
variable "target_id" {
  description = "The ID of the target (EC2 instance) to attach to the ALB target group"
  type        = string
}
*/