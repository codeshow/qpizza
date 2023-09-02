resource "aws_db_subnet_group" "that" {
  subnet_ids = var.subnet_ids
  description = "Subnet group for RDS"
}

data "aws_ssm_parameter" "db_username" {
  name = "db_username"
}

data "aws_ssm_parameter" "db_password" {
  name = "db_password"
}

resource "aws_security_group" "that" {
  name = "that"
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

resource "aws_rds_cluster" "aurora_cluster" {
    engine = "aurora-mysql"
    engine_mode = "provisioned"
    engine_version = "8.0"

    db_subnet_group_name = aws_db_subnet_group.that.name
    vpc_security_group_ids = [ aws_security_group.that.id ]
    master_username = data.aws_ssm_parameter.db_username.value
    master_password = data.aws_ssm_parameter.db_password.value
    backup_retention_period = 7
    preferred_backup_window = "07:00-09:00"
    storage_encrypted = true
    skip_final_snapshot = true

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