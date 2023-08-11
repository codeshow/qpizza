resource "aws_security_group" "aurora_sg" {
  description = "Security group for RDS"
  vpc_id = var.vpc_id
  ingress {
    from_port = 3306
    to_port = 3306
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_db_subnet_group" "that" {
  subnet_ids = var.subnet_ids
  description = "Subnet group for RDS"
}

#TODO: Prefix the parameter names with the environment name
data "aws_ssm_parameter" "master_username" {
  name = "master_username"
}

data "aws_ssm_parameter" "master_password" {
  name = "master_password"
}

resource "aws_rds_cluster" "aurora_cluster" {
  engine                  = "aurora-mysql"
  engine_mode             = "provisioned"
  engine_version          = "8.0"
  
  db_subnet_group_name    = aws_db_subnet_group.that.name
  master_username         = data.aws_ssm_parameter.master_username.value
  master_password         = data.aws_ssm_parameter.master_password.value
  backup_retention_period = 7
  preferred_backup_window = "07:00-09:00"
  vpc_security_group_ids  = [aws_security_group.aurora_sg.id]
  storage_encrypted       = true
  skip_final_snapshot     = true
  enable_http_endpoint    = true

  serverlessv2_scaling_configuration {
    min_capacity = 0.5
    max_capacity = 8
  }
}

resource "aws_rds_cluster_instance" "cluster_instances" {
  cluster_identifier = aws_rds_cluster.aurora_cluster.id
  instance_class = "db.serverless"
  engine = aws_rds_cluster.aurora_cluster.engine
  engine_version = aws_rds_cluster.aurora_cluster.engine_version
}