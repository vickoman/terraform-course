provider "aws" {
    region = "us-east-2"
    shared_credentials_file = "~/.aws/credentials"
    profile = "default"
}

# VPC creation
resource "aws_vpc" "vicko-vcp-1" {
    cidr_block = "10.0.0.0/16"
    enable_dns_hostnames = true

    tags = {
        Name = "vicko-vcp-1"
    }
}

resource "aws_subnet" "subnet1" {
    vpc_id = "${aws_vpc.vicko-vcp-1.id}"
    cidr_block = "10.0.10.0/24"
    map_public_ip_on_launch = true
    availability_zone = "us-east-2a"

    tags = {
        Name = "Subnet 1 - vickovpc1"
    }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = "${aws_vpc.vicko-vcp-1.id}"
  tags = {
      Name = "Gateway Main"
  }
}

resource "aws_route_table" "r" {
    vpc_id = "${aws_vpc.vicko-vcp-1.id}"

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.gw.id}"
    }

}