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
  type = list(string)
}

variable "public_subnets" {
  description = "list of public subnets"
  type = list(string)
}

variable "private_subnets" {
  description = "list of private subnets"
  type = list(string)
}

variable "sg_name" {
  description = "Name of the Security Group"
  type        = string
}

variable "description" {
  description = "Description of the Security Group"
  type        = string
}

variable ingress_rules {
    description = "The ingress rules for the security group"
    type        = list(object({
        description = string
        from_port   = number
        to_port     = number
        protocol    = string
        cidr_blocks = list(string)
    }))
}

variable egress_rules {
    description = "The egress rules for the security group"
    type        = list(object({
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

variable "subnet_id" {
  description = "Subnet ID for the EC2 instance"
  type        = string
}

variable "security_group_ids" {
  description = "List of security group IDs for the EC2 instance"
  type        = list(string)
}

variable "associate_public_ip" {
  description = "Whether to associate a public IP address with the EC2 instance"
  type        = bool
}

variable "instance_name" {
  description = "The name for the EC2 instance"
  type        = string
}