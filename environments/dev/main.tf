module "vpc" {
  source = "../../modules/vpc"

  proj_name  = var.proj_name
  cidr_block = var.cidr_block
  env        = var.env
  azs        = var.azs
  public_subnets = var.public_subnets
  private_subnets = var.private_subnets
}

module "bastion_sg" {
  source = "../../modules/security-group"

  project_name = var.proj_name
  environment  = var.env
  vpc_id       = module.vpc.vpc_id
  name         = var.bastion_sg_name
  description  = var.bastion_sg_description
  ingress_rules = var.bastion_sg_ingress_rules
  egress_rules  = var.bastion_sg_egress_rules
}

module "application_sg" {
  source = "../../modules/security-group"

  project_name = var.proj_name
  environment  = var.env
  vpc_id       = module.vpc.vpc_id
  name         = var.application_sg_name
  description  = var.application_sg_description
  ingress_rules = var.application_sg_ingress_rules
  egress_rules  = var.application_sg_egress_rules
}

module "bastion_server" {
  source = "../../modules/ec2"

  ami_id               = var.ami_id
  instance_type        = var.instance_type
  subnet_id            = module.vpc.public_subnet_ids[0]
  security_group_ids   = [module.bastion_sg.id]
  associate_public_ip  = var.bastion_associate_public_ip
  instance_name        = var.bastion_instance_name
  project_name         = var.proj_name
  environment          = var.env
  key_name            = var.key_name
}

module "application_server" {
  source = "../../modules/ec2"

  ami_id               = var.ami_id
  instance_type        = var.instance_type
  subnet_id            = module.vpc.private_subnet_ids[0]
  security_group_ids   = [module.application_sg.id]
  associate_public_ip  = var.application_associate_public_ip
  instance_name        = var.application_instance_name
  project_name         = var.proj_name
  environment          = var.env
  key_name            = null
}

module "alb" {
  source = "../../modules/alb"

  name                     = var.alb_name
  internal                 = var.alb_internal
  security_groups          = [module.application_sg.id]
  subnets                  = module.vpc.public_subnet_ids
  enable_deletion_protection = var.alb_enable_deletion_protection
  vpc_id                   = module.vpc.vpc_id
  target_id                = module.application_server.instance_id
}