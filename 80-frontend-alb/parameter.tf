resource "aws_ssm_parameter" "frontend_alb_arn_listiner" {
  name  = "/${var.project_name}/${var.environment}/frontend_alb_arn_listiner"
  type  = "String"
  value = aws_lb_listener.frontend_https_listener.arn
}