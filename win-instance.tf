resource "aws_instance" "win-appserver" {
  ami = var.AMIS_WIN_SRV_2016[var.AWS_REGION]
  instance_type = "t2.micro"

  # the VPC subnet
  subnet_id = element(module.main-vpc.public_subnets, 0)

  # the security group
  vpc_security_group_ids = [aws_security_group.appserver-securitygroup.id]

  # the public SSH key
  key_name = aws_key_pair.mykeypair.key_name

  # ec2 role
  iam_instance_profile = aws_iam_instance_profile.s3-mybucket-role-instanceprofile.name

  tags = {
    Name = "win-appserver"
    "Project Name" = var.AWS_PROJECT_NAME
  }

  user_data     = <<EOF
    <powershell>
      C:\ProgramData\Amazon\EC2-Windows\Launch\Scripts\InitializeDisks.ps1
      
      net user ${var.INSTANCE_USERNAME} '${var.INSTANCE_PASSWORD}' /add /y
      net localgroup administrators ${var.INSTANCE_USERNAME} /add

      netsh advfirewall firewall add rule name="ZENAHTTP 80" protocol=TCP dir=in localport=80 action=allow
      
      Read-S3Object -BucketName ${var.S3_BUCKET_NAME} -KeyPrefix ${var.S3_INSTALLBLES_KEY_PREFIX} -Folder "D:\zena-installables"

    </powershell>
  EOF
}

resource "aws_ebs_volume" "appserver-ebs-volume" {
  availability_zone = "${var.AWS_REGION}a"
  size = 20
  type = "gp2"
  tags = {
    Name = "appserver-ebs-volume"
    "Project Name" = var.AWS_PROJECT_NAME
  }
}

resource "aws_volume_attachment" "data-attachment" {
  device_name  = var.INSTANCE_DEVICE_NAME
  volume_id    = aws_ebs_volume.appserver-ebs-volume.id
  instance_id  = aws_instance.win-appserver.id
  skip_destroy = true
}