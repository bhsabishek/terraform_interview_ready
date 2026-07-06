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
  key_name             = var.key_name
  iam_instance_profile = module.iam.instance_profile_name
}

/*
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
*/

module "alb" {
  source = "../../modules/alb"

  name                     = var.alb_name
  internal                 = var.alb_internal
  security_groups          = [module.application_sg.id]
  subnets                  = module.vpc.public_subnet_ids
  enable_deletion_protection = var.alb_enable_deletion_protection
  vpc_id                   = module.vpc.vpc_id
  //target_id                = module.asg.target_group_arn
}

module "asg" {
  source = "../../modules/asg"

  ami_id               = var.ami_id
  instance_type        = var.instance_type
  security_group_ids   = [module.application_sg.id]
  //key_name             = var.key_name
  environment          = var.env
  instance_name        = var.asg_instance_name
  subnet_ids            = module.vpc.private_subnet_ids
  alb_target_group_arn = module.alb.target_group_arn
  lt_name_prefix       = "${var.proj_name}-${var.env}-lt"
  iam_instance_profile_name = module.iam.instance_profile_name
}

data "aws_iam_policy_document" "assume_role" {

  statement {
    effect = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

data "aws_caller_identity" "this" {}
data "aws_region" "this" {
  
}

data "aws_iam_policy_document" "custom" {
  statement {
    sid = "CloudWatchLogs"
    actions = [
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]
    resources = [
      "arn:aws:logs:${data.aws_region.this.region}:${data.aws_caller_identity.this.account_id}:log-group:/aws/ec2/${var.proj_name}:*"
    ]
  }

  statement {
    sid = "SSMParameterStore"
    actions = [
      "ssm:GetParameter",
      "ssm:GetParameters"
    ]
    resources = [
      "arn:aws:ssm:${data.aws_region.this.region}:${data.aws_caller_identity.this.account_id}:parameter/${var.proj_name}/*"
    ]
  }

  statement {
    sid = "S3Read"
    actions = [
      "s3:GetObject"
    ]
    resources = [
      "arn:aws:s3:::${var.bucket_name}/*"
    ]
  }
}

module "iam" {
  source = "../../modules/iam"

  proj_name = var.proj_name
  env = var.env
  policy = data.aws_iam_policy_document.custom.json
  policy_name = var.policy_name
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

module "s3" {
  source = "../../modules/s3"

  project_name = var.proj_name
  environment = var.env
  bucket_name = var.backend_bucket_name
}