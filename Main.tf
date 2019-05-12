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
provider "aws" {
    region = "${var.region}"
    shared_credentials_file = "${var.shared_cred_file}"
    profile = "default"
}
resource "aws_eip" "ip" {
    instance = "${aws_instance.embedded_shopify_app.id}"
}
resource "aws_instance" "embedded_shopify_app" {
    ami = "ami-04481c741a0311bbb"
    instance_type = "t2.large"
    user_data = <<-EOF
        #!/bin/bash
        git clone https://github.com/NickMoignard/shopify_embedded_app.git;
        cd shopify_embedded_app-master;
        bundle update;
        bundle;
        EOF
    key_name = "shopify_app_nlm"
    tags {
        Name = "Large-EC2"
    }
}
resource "aws_security_group" "instance" {
    name = "Large-EC2-instance"
    ingress {
        from_port = "${var.server_port}"
        to_port = "${var.server_port}"
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
}
output "public_ip" {
    value = "${aws_instance.embedded_shopify_app.public_ip}"
}
