resource "aws_iam_role" "this" {
    name               = "${var.proj_name}-${var.env}-iam-role"
    assume_role_policy = var.assume_role_policy
}

resource "aws_iam_policy" "this" {
    name = var.policy_name
    policy = var.policy
}

resource "aws_iam_role_policy_attachment" "this" {
    role       = aws_iam_role.this.name
    policy_arn = aws_iam_policy.this.arn
}

resource "aws_iam_instance_profile" "this" {
    name = "${var.proj_name}-${var.env}-iam-instance-profile"
    role = aws_iam_role.this.name
}