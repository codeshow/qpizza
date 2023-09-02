resource "aws_ssm_parameter" "db_username" {
  name  = "db_username"
  type  = "String"
  value = var.db_username
}

resource "aws_ssm_parameter" "db_password" {
  name  = "db_password"
  type  = "String"
  value = var.db_password != "" ? var.db_password : uuid()
}