resource "aws_ssm_parameter" "master_username" {
  name  = "master_username"
  type  = "String"
  value = var.master_username
}

resource "aws_ssm_parameter" "master_password" {
  name  = "master_password"
  type  = "String"
  value = (var.master_password != "" ? var.master_password : uuid())
}