variable ami_id {
    description = "The AMI ID for the EC2 instance"
    type        = string
}

variable instance_type {
    description = "The instance type for the EC2 instance"
    type        = string
}

variable subnet_id {
    description = "The subnet ID for the EC2 instance"
    type        = string
}

variable security_group_ids {
    description = "The security group IDs for the EC2 instance"
    type        = list(string)
}

variable associate_public_ip {
    description = "Whether to associate a public IP address with the EC2 instance"
    type        = bool
}

variable instance_name {
    description = "The name for the EC2 instance"
    type        = string
}

variable project_name {
    description = "The name of the project"
    type        = string
}

variable environment {
    description = "The environment for the EC2 instance"
    type        = string
}