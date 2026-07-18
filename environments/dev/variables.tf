variable "cidr_block" {
  description = "cidr_block value for creating VPC"
  type        = string
}

variable "env" {
  description = "Env VPC is getting created"
  type        = string
}

variable "proj_name" {
  description = "Name of the Project"
  type        = string
}

variable "azs" {
  description = "List of AZS"
  type        = list(string)
}

variable "public_subnets" {
  description = "list of public subnets"
  type        = list(string)
}

variable "private_subnets" {
  description = "list of private subnets"
  type        = list(string)
}

variable "bastion_sg_name" {
  description = "Name of the Security Group"
  type        = string
}

variable "bastion_sg_description" {
  description = "Description of the Security Group"
  type        = string
}

variable "bastion_sg_ingress_rules" {
  description = "The ingress rules for the security group"
  type = list(object({
    description = string
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
}

variable "bastion_sg_egress_rules" {
  description = "The egress rules for the security group"
  type = list(object({
    description = string
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
}

variable "application_sg_name" {
  description = "Name of the Security Group"
  type        = string
}

variable "application_sg_description" {
  description = "Description of the Security Group"
  type        = string
}

variable "application_sg_ingress_rules" {
  description = "The ingress rules for the security group"
  type = list(object({
    description = string
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
}

variable "application_sg_egress_rules" {
  description = "The egress rules for the security group"
  type = list(object({
    description = string
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
}

variable "rds_sg_name" {
  description = "Name of the RDS"
  type        = string
}

variable "rds_sg_description" {
  description = "Description of the Security Group"
  type        = string
}

variable "rds_sg_ingress_rules" {
  description = "The ingress rules for the security group"
  type = list(object({
    description = string
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = optional(list(string))
  }))
}

variable "rds_sg_egress_rules" {
  description = "The egress rules for the security group"
  type = list(object({
    description = string
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
}

variable "ami_id" {
  description = "AMI ID for the EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "Instance type for the EC2 instance"
  type        = string
}

/*
variable "application_associate_public_ip" {
  description = "Whether to associate a public IP address with the application EC2 instance"
  type        = bool
}

variable "application_instance_name" {
  description = "The name for the application EC2 instance"
  type        = string
}
*/

variable "bastion_instance_name" {
  description = "The name for the baston EC2 instance"
  type        = string
}

variable "bastion_associate_public_ip" {
  description = "Whether to associate a public IP address with the bastion EC2 instance"
  type        = bool
}

variable "key_name" {
  description = "The name of the key pair to use for the EC2 instance"
  type        = string
}

variable "alb_name" {
  description = "The name of the ALB"
  type        = string
}

variable "alb_internal" {
  description = "Boolean to indicate if the ALB is internal or internet-facing"
  type        = bool
  default     = false
}

variable "alb_enable_deletion_protection" {
  description = "Boolean to enable deletion protection for the ALB"
  type        = bool
  default     = false
}

variable "asg_instance_name" {
  description = "The name for the EC2 instances in the Auto Scaling Group"
  type        = string
}

variable "bucket_name" {
  description = "The name of the S3 bucket"
  type        = string
}

variable "policy_name" {
  description = "policy name"
  type        = string
}

variable "backend_bucket_name" {
  description = "backend s3 bucket name"
  type        = string
}

variable "db_name" {
  type = string
}

variable "db_username" {
  type = string
}

variable "db_password" {
  type      = string
  sensitive = true
}

variable "engine" {
  type = string
}

variable "instance_class" {
  type = string
}

variable "storage_type" {
  type = string
}

variable "allocated_storage" {
  type = number
}

variable "multi_az" {
  type = bool
}

variable "publicly_accessible" {
  type = bool
}

variable "deletion_protection" {
  type = bool
}

variable "skip_final_snapshot" {
  type = bool
}