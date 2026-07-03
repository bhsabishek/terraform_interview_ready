resource "aws_alb" "this" {
    name               = var.name
    internal           = var.internal
    security_groups    = var.security_groups
    subnets            = var.subnets
    enable_deletion_protection = var.enable_deletion_protection
}

resource "aws_alb_target_group" "this" {
    name     = "${var.name}-tg"
    port     = 80
    protocol = "HTTP"
    vpc_id   = var.vpc_id
    target_type = "instance"
    health_check {
        path                = "/"
        interval            = 30
        timeout             = 5
        healthy_threshold   = 3
        unhealthy_threshold = 3
        matcher             = "200-299"
    }
}

resource "aws_alb_listener" "this" {
    load_balancer_arn = aws_alb.this.arn
    port                = 80
    protocol            = "HTTP"
    default_action {
        target_group_arn = aws_alb_target_group.this.arn
        type             = "forward"
    }
}

resource "aws_alb_target_group_attachment" "this" {
    target_group_arn = aws_alb_target_group.this.arn
    target_id        = var.target_id
    port             = 80
}