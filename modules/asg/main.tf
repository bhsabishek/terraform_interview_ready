resource "aws_launch_template" "this" {
  name_prefix            = var.lt_name_prefix
  image_id               = var.ami_id
  instance_type          = var.instance_type
  vpc_security_group_ids = var.security_group_ids
  //key_name               = var.key_name

  iam_instance_profile {
    name = var.iam_instance_profile_name
  }
}

resource "aws_autoscaling_group" "this" {
  vpc_zone_identifier = var.subnet_ids

  min_size         = 2
  max_size         = 4
  desired_capacity = 2

  health_check_type         = "ELB"
  health_check_grace_period = 300

  target_group_arns = [var.alb_target_group_arn]

  launch_template {
    id      = aws_launch_template.this.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = var.instance_name
    propagate_at_launch = true
  }
}