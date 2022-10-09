# Create a Basic VPC and Associated Components in AWS

## Introduction

AWS networking consists of multiple components, and understanding the relationship between the networking components is a key part of understanding the overall functionality and capabilities of AWS. In this hands-on lab, we will create a VPC with an internet gateway, as well as create subnets across multiple Availability Zones.

## Prerequisites

Use the credentials provided to log in to the AWS Management Console. Make sure you are in the  `us-east-1`  region.

## Challenge Objectives

Create an Internet Gateway, and Connect It to the VPC

Create an internet gateway, and attach it to the  `VPC1`  VPC.

Create a VPC

1.  Create a VPC from scratch (without using the VPC Wizard).
2.  Name the VPC  `VPC1`
3.  Set the VPC CIDR to 172.16.0.0/16.

Create a Public and Private Subnet in Different Availability Zones

Create a public and private subnet in different Availability Zones using the following IP CIDR addresses:

-   `Public1`  subnet in  `us-east-1a`: 172.16.1.0/24
-   `Private1`  subnet in  `us-east-1b`: 172.16.2.0/24

Create Two Route Tables, and Associate Them with the Correct Subnet

> **Note**: The VPC has a default route table, but we will be creating custom route tables.

1.  Create two route tables:
    -   One for the public subnet named  `PublicRT`  with an internet gateway route
    -   One for the private subnet named  `PrivateRT`  without an internet gateway route
2.  For the public route table, create a default route to the internet using the 0.0.0.0/0 CIDR notation.

Create Two Network Access Control Lists (NACLs), and Associate Each with the Proper Subnet

1.  Create a public NACL named  `Public_NACL`with inbound rules allowing HTTP and SSH traffic, as well as an outbound rule allowing TCP traffic on port range 1024-65535.
    
2.  Associate the public NACL with the public subnet.
    
3.  Create a private NACL named  `Private_NACL`with an inbound rule allowing SSH traffic with a source of 172.16.1.0/24, as well as an outbound rule allowing TCP traffic on port range 1024-65535.
    
4.  Associate the private NACL with the private subnet.
