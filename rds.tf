resource "aws_db_subnet_group" "db-subnet" {
  name = "db-subnet"
  description = "RDS subnet group"
  subnet_ids = module.main-vpc.public_subnets
}

resource "aws_db_instance" "mssql" {
  engine = "sqlserver-ex"
  engine_version = "14.00.3281.6.v1"
  allocated_storage = 20                                                        # 100 GB of storage, gives us more IOPS than a lower number
  apply_immediately = true
  storage_type = "gp2"
  instance_class = "db.t2.micro"                                                # use micro if you want to use the free tier
  identifier = "mssqlinstance"  
  username = "sa"                                                               # username
  password = "Welcome123!"                                                      # password
  db_subnet_group_name = aws_db_subnet_group.db-subnet.name
  multi_az = "false"                                                            # set to true to have high availability: 2 instances synchronized with each other
  vpc_security_group_ids = [aws_security_group.rds-securitygroup.id]
  backup_retention_period = 30                                                  # how long you’re going to keep your backups
  availability_zone = element(data.aws_availability_zones.available.names, 0)   # prefered AZ
  skip_final_snapshot = true                                                    # skip final snapshot when doing terraform destroy
  publicly_accessible = true
  tags = {
    Name = "mssql-instance"
    "Project Name" = var.AWS_PROJECT_NAME
  }
}
