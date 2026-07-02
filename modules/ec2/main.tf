resource "aws_instance" "my_ec2" {
    ami                    = var.ami_id
    instance_type          = var.instance_type
    subnet_id              = var.subnet_id
    vpc_security_group_ids = var.security_group_ids
    associate_public_ip_address = var.associate_public_ip
    
    tags = {
        Name        = "${var.project_name}-${var.environment}-${var.instance_name}"
        Project     = var.project_name
        Environment = var.environment
        ManagedBy   = "Terraform"
    }
}