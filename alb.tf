resource "aws_lb" "alb" {
  name               = var.ALB_NAME
  internal           = var.INTERNAL
  load_balancer_type = "application"
  security_groups    = var.INTERNAL ? [aws_security_group.alb_private.*.id] : [aws_security_group.alb_public.*.id] # If we are calling this for public load balancer value should be PUBLIC SUBNET GROUP/ It you are calling for private LB the value should be PRIVATE SUBNET GROUP
  subnets            = var.INTERNAL ? data.terraform_remote_state.vpc.outputs.PRIVATE_SUBNET_IDS : data.terraform_remote_state.vpc.outputs.PUBLIC_SUBNET_IDS  # CONDITIONAL EXPRESSION

  tags = {
    Environment = "var.ALB_NAME"
  }
}