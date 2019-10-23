resource "aws_db_instance" "dev-rds" {
  allocated_storage    = 20
  storage_type         = "gp2"
  engine               = "mariadb"
  engine_version       = "10.3"
  instance_class       = "db.t2.micro"
  name                 = "studentapp"
  username             = "${var.DBUSER}"
  password             = "${var.DBPASS}"
  parameter_group_name = "default.mariadb10.3"
  skip_final_snapshot = true
  identifier = "studentapp-rds-dev"
  db_subnet_group_name = "test-env-subnet-group"
  vpc_security_group_ids = ["sg-0b4e3b9d8afb00cb4"] 
}