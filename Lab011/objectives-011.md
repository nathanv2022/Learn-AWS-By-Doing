# Building a Three-Tier Network VPC from Scratch in AWS

## Description

This lab provides you with the opportunity to get hands-on experience building and connecting the following components inside AWS:

1.  VPC
2.  Subnets
3.  Internet Gateway
4.  Route Tables
5.  Nat Gateway
6.  Network Access Control Lists (NACLs)

These components are the foundation of highly available/fault tolerant networking architecture inside of AWS, while covering concepts such as infrastrucutre, design, routing, and security.

The bare-bones architecture we built in this lab is a design you will frequently see when working in AWS. Good luck and enjoy this hands-on lab.

## Objectives

### Create a VPC

Create a VPC with the following CIDR Block Range (10.99.0.0/16)

-   Navigate to the VPC service in the AWS Console
-   Navigate to "your vpcs"
-   Click on Create VPC
-   Enter VPC name and CIDR block range
-   Create an Internet Gateway and attach it to your VPC.

### Create six (6) Subnets

Create six (6) subnets in the VPC you just created. One pair of subnets for the DMZ layer, one pair for the AppLayer, and one pair for the DBLayer. Each pair should be split between AZs.

-   In the VPC console, navigate to "subnets"
-   Select "create subnet"
-   Fill in the form, making sure to select the proper VPC, AZ, and CIDR block range
-   Repeat 5 more times to create six total subnets

### Create a NAT Gateway

Create a NAT Gateway and provide it with a route to the Internet via the public Route Table

-   In the VPC console, navigate to "Nat Gateways"
-   Click on "Create Nat Gateway"
-   Fill out the form, making sure to choose the appropriate subnet AND generating an EIP address

### Create three (3) NACLs and associate them with subnets

Create three NACLs and associate each to one of the subnet groupings (DMZ, AppLayer, and DB layer subnets)

Create Three NACLs:

-   In the VPC console, navigate to "Network ACLs"
-   Click on "Create Network ACL"
-   Fill out the form, making sure to select the proper VPC.
-   Repeat twice more to create a total of three NACLs

### Associate NACLs with Subnets:

-   Select one NACL and navigate to the "Subnet Associations" tab
-   Click on "Edit"
-   Select the two subnets that need to be associated with this NACL.
-   Click "Save"
-   Repeat twice more, associating the remaining NACLs with the remaining subnets.

### Delete resouces with dependency
- Delete NAT GW
- Release Elastic IP
- Delete VPC



