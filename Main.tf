variable "server_port" {
    description = "The port the server will use for HTTP requests"
    default = 3000
}
variable "shared_cred_file" {
    default = "~/shopify_app_nlm.pem"
}
variable "region" {
    default = "ap-southeast-2"
}
variable "vpc-id" {
    default = "vpc-298b5f4d"
}

provider "aws" {
    region = "${var.region}"
    shared_credentials_file = "${var.shared_cred_file}"
    profile = "default"
}
resource "aws_vpc" "shopify-embedded-app-env" {
  cidr_block = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support = true
  tags {
    Name = "shopify-embedded-app-env"
  }
}
resource "aws_eip" "ip-shopify-embedded-app-env" {
  instance = "${aws_instance.embedded_shopify_app.id}"
  vpc      = true
}

resource "aws_subnet" "subnet-uno" {
  cidr_block = "${cidrsubnet(aws_vpc.shopify-embedded-app-env.cidr_block, 3, 1)}"
  vpc_id = "${aws_vpc.shopify-embedded-app-env.id}"
  availability_zone = "ap-southeast-2b"
}
resource "aws_security_group" "ingress-all-shopify-embedded-app" {
name = "allow-all-sg"
vpc_id = "${aws_vpc.shopify-embedded-app-env.id}"
ingress {
    cidr_blocks = [
      "0.0.0.0/0"
    ]
from_port = 22
    to_port = 22
    protocol = "tcp"
  }
// Terraform removes the default rule
  egress {
   from_port = 0
   to_port = 0
   protocol = "-1"
   cidr_blocks = ["0.0.0.0/0"]
 }
}
resource "aws_instance" "embedded_shopify_app" {
    ami = "ami-0d4ca363b8b7d88b7"
    instance_type = "t2.large"
    user_data = <<-EOF
        #!/bin/bash
        git clone https://github.com/NickMoignard/shopify-embedded-app-v2.git;
        cd shopify_embedded_app-master;
		4

        bundle update;
        bundle;
        EOF
    key_name = "shopify_app_nlm"
    security_groups = ["${aws_security_group.ingress-all-shopify-embedded-app.id}"]
    tags {
        Name = "Large-EC2"
    }
    subnet_id = "${aws_subnet.subnet-uno.id}"
}
resource "aws_security_group" "allow_ssh" {
    name = "allow_all"
    description = "Allow inbound SSH traffic from my IP"
    vpc_id = "${var.vpc-id}"

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["220.240.197.182/32"]
    }
}
resource "aws_internet_gateway" "shopify-embedded-app-env-gw" {
  vpc_id = "${aws_vpc.shopify-embedded-app-env.id}"
tags {
    Name = "shopify-embedded-app-env-gw"
  }
}
resource "aws_route_table" "route-table-shopify-embedded-app-env" {
  vpc_id = "${aws_vpc.shopify-embedded-app-env.id}"
route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.shopify-embedded-app-env-gw.id}"
  }
tags {
    Name = "shopify-embedded-app-env-route-table"
  }
}
resource "aws_route_table_association" "subnet-association" {
  subnet_id      = "${aws_subnet.subnet-uno.id}"
  route_table_id = "${aws_route_table.route-table-shopify-embedded-app-env.id}"
}
output "public_ip" {
    value = "${aws_instance.embedded_shopify_app.public_ip}"
}
