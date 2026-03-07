resource "aws_ssm_parameter" "backend_alb_arn_listiner" {
  name  = "/${var.project_name}/${var.environment}/backend_alb_arn_listiner"
  type  = "String"
  value = aws_lb_listener.loabalbbackendlistiner.arn
}