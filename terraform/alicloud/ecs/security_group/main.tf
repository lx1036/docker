
# Provider
provider "alicloud" {
  version = "~> 1.48"
  access_key = "${var.AccessKeyID}"
  secret_key = "${var.AccessKeySecret}"
}


# Variables
variable "AccessKeyID" {}

variable "AccessKeySecret" {}

variable "sg_name" {
  default = "alicloud_sg_1"
}

variable "vpc_id" {}

# Resources
resource "alicloud_security_group" "main" {
  name = "${var.sg_name}"
  description = "Default security group for VPC"
  vpc_id = "${var.vpc_id}"
}
