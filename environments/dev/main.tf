module "vpc" {
  source = "../../modules/vpc"

  proj_name  = var.proj_name
  cidr_block = var.cidr_block
  env        = var.env
  azs        = var.azs
  public_subnets = var.public_subnets
  private_subnets = var.private_subnets
}

module "security_group" {
  source = "../../modules/security-group"

  project_name = var.proj_name
  environment  = var.env
  vpc_id       = module.vpc.vpc_id
  name         = var.sg_name
  description  = var.description
  ingress_rules = var.ingress_rules
  egress_rules  = var.egress_rules
}

module "ec2" {
  source = "../../modules/ec2"

  ami_id               = var.ami_id
  instance_type        = var.instance_type
  subnet_id            = module.vpc.public_subnet_ids[0]
  security_group_ids   = [module.security_group.id]
  associate_public_ip  = var.associate_public_ip
  instance_name        = var.instance_name
  project_name         = var.proj_name
  environment          = var.env
}