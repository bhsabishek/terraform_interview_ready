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