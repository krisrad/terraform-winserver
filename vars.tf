variable "AWS_ACCESS_KEY" {
  type = string
}
variable "AWS_SECRET_KEY" {
  type = string
}
variable "AWS_REGION" {}

variable "AWS_PROJECT_NAME" {}

variable "PATH_TO_PRIVATE_KEY" {
  default = "mykey"
}

variable "PATH_TO_PUBLIC_KEY" {
  default = "mykey.pub"
}

variable "AMIS_WIN_SRV_2016" {
  type = map
}

variable "INSTANCE_DEVICE_NAME" {
  default = "/dev/xvdh"
}

variable "EC2_INSTANCE_TYPE" {}

variable "INSTANCE_USERNAME" {}

variable "INSTANCE_PASSWORD" {}

variable "S3_BUCKET_NAME" {}

variable "S3_INSTALLBLES_KEY_PREFIX" {}
