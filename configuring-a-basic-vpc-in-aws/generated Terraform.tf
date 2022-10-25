terraform {
    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = "~> 3.0"
        }
    }
}

provider "aws" {
    region = "us-east-1"
}

resource "aws_security_group" "EC2SecurityGroup" {
    description = "launch-wizard-1 created 2022-10-05T22:33:20.997Z"
    name = "launch-wizard-1"
    tags = ""
    vpc_id = "${aws_vpc.EC2VPC.id}"
    ingress {
        security_groups = [
            "${aws_security_group.EC2SecurityGroup2.id}"
        ]
        from_port = 22
        protocol = "tcp"
        to_port = 22
    }
    ingress {
        security_groups = [
            "${aws_security_group.EC2SecurityGroup2.id}"
        ]
        from_port = -1
        protocol = "icmp"
        to_port = -1
    }
    egress {
        cidr_blocks = [
            "0.0.0.0/0"
        ]
        from_port = 0
        protocol = "-1"
        to_port = 0
    }
}

resource "aws_security_group" "EC2SecurityGroup2" {
    description = "holpubSG"
    name = "holpubSG"
    tags = ""
    vpc_id = "${aws_vpc.EC2VPC.id}"
    ingress {
        cidr_blocks = [
            "73.119.61.0/32"
        ]
        from_port = 22
        protocol = "tcp"
        to_port = 22
    }
    egress {
        cidr_blocks = [
            "0.0.0.0/0"
        ]
        from_port = 0
        protocol = "-1"
        to_port = 0
    }
}

resource "aws_subnet" "EC2Subnet" {
    availability_zone = "us-east-1b"
    cidr_block = "10.0.2.0/24"
    vpc_id = "${aws_vpc.EC2VPC.id}"
    map_public_ip_on_launch = true
}

resource "aws_subnet" "EC2Subnet2" {
    availability_zone = "us-east-1a"
    cidr_block = "10.0.1.0/24"
    vpc_id = "${aws_vpc.EC2VPC.id}"
    map_public_ip_on_launch = false
}

resource "aws_instance" "EC2Instance" {
    ami = "ami-026b57f3c383c2eec"
    instance_type = "t3.micro"
    key_name = "vpcpubhol"
    availability_zone = "us-east-1a"
    tenancy = "default"
    subnet_id = "subnet-07878c858d861a6e6"
    ebs_optimized = true
    vpc_security_group_ids = [
        "${aws_security_group.EC2SecurityGroup2.id}"
    ]
    source_dest_check = true
    root_block_device {
        volume_size = 8
        volume_type = "gp2"
        delete_on_termination = true
    }
    tags = ""
}

resource "aws_instance" "EC2Instance2" {
    ami = "ami-026b57f3c383c2eec"
    instance_type = "t3.micro"
    key_name = "vpcprivhol"
    availability_zone = "us-east-1b"
    tenancy = "default"
    subnet_id = "subnet-00b1588160c53ab5f"
    ebs_optimized = true
    vpc_security_group_ids = [
        "${aws_security_group.EC2SecurityGroup.id}"
    ]
    source_dest_check = true
    root_block_device {
        volume_size = 8
        volume_type = "gp2"
        delete_on_termination = true
    }
    tags = ""
}

resource "aws_volume_attachment" "EC2VolumeAttachment" {
    volume_id = "vol-0f073a71c52000ba6"
    instance_id = "i-0fc72213174656b73"
    device_name = "/dev/xvda"
}

resource "aws_volume_attachment" "EC2VolumeAttachment2" {
    volume_id = "vol-077e54bd6b823e7b1"
    instance_id = "i-03f9d2d5ebf748eb7"
    device_name = "/dev/xvda"
}

resource "aws_network_interface_attachment" "EC2NetworkInterfaceAttachment" {
    network_interface_id = "eni-0614099dffae7d8b6"
    device_index = 0
    instance_id = "i-03f9d2d5ebf748eb7"
}

resource "aws_network_interface_attachment" "EC2NetworkInterfaceAttachment2" {
    network_interface_id = "eni-0826abb7835969e16"
    device_index = 0
    instance_id = "i-0fc72213174656b73"
}

resource "aws_vpc" "EC2VPC" {
    cidr_block = "10.0.0.0/16"
    enable_dns_support = true
    enable_dns_hostnames = false
    instance_tenancy = "default"
    tags = ""
}
