module "main-vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "2.6.0"

  name = "main-vpc"
  cidr = "10.0.0.0/16"

  azs = slice(data.aws_availability_zones.available.names, 0, 2)
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24"]
  private_subnets  = ["10.0.201.0/24", "10.0.202.0/24"]

  enable_nat_gateway = false
  enable_vpn_gateway = false
  enable_dns_hostnames = true

  tags = {
    "Name" = "main-vpc"
    "Project Name" = var.AWS_PROJECT_NAME
  }
}
