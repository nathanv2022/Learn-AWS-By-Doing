
# Creating a Basic VPC and Associated Components

## Introduction

In this hands-on lab, we will create a VPC with an internet gateway, as well as create subnets across multiple Availability Zones.

## Solution

Log in to the live AWS environment using the credentials provided. Make sure you're in the N. Virginia (`us-east-1`) region throughout the lab.

### Create a VPC

1.  Navigate to the VPC dashboard.
2.  Click  **Your VPCs**  in the left-hand menu.
3.  Click  **Create VPC**, and set the following values:
    -   _Name tag_:  **VPC1**
    -   _IPv4 CIDR block_:  **172.16.0.0/16**
4.  Leave the  _IPv6 CIDR block_  and  _Tenancy_  fields as their default values.
5.  Click  **Create**.

### Create an Internet Gateway, and Connect It to the VPC

1.  Click  **Internet Gateways**  in the left-hand menu.
2.  Click  **Create internet gateway**.
3.  Give it a  _Name tag_  of "IGW".
4.  Click  **Create internet gateway**.
5.  Once it's created, click  **Actions**  >  **Attach to VPC**.
6.  In the  _Available VPCs_  dropdown, select our  **VPC1**.
7.  Click  **Attach internet gateway**.

### Create a Public and Private Subnet in Different Availability Zones

#### Create Public Subnet

1.  Click  **Subnets**  in the left-hand menu.
2.  Click  **Create subnet**, and set the following values:
    -   _Name tag_:  **Public1**
    -   _VPC_:  **VPC1**
    -   _Availability Zone_:  **us-east-1a**
    -   _IPv4 CIDR block_:  **172.16.1.0/24**
3.  Click  **Create**.

#### Create Private Subnet

1.  Click  **Create subnet**, and set the following values:
    -   _Name tag_:  **Private1**
    -   _VPC_:  **VPC1**
    -   _Availability Zone_:  **us-east-1b**
    -   _IPv4 CIDR block_:  **172.16.2.0/24**
2.  Click  **Create**.

### Create Two Route Tables, and Associate Them with the Correct Subnet

#### Create and Configure Public Route Table

Note: The VPC has a default route table, but we will be creating custom route tables.

1.  Click  **Route Tables**  in the left-hand menu.
2.  Click  **Create route table**, and set the following values:
    -   _Name tag_:  **PublicRT**
    -   _VPC_:  **VPC1**
3.  Click  **Create**.
4.  With  _PublicRT_  selected, click the  **Routes**  tab on the page.
5.  Click  **Edit routes**.
6.  Click  **Add route**, and set the following values:
    -   _Destination_:  **0.0.0.0/0**
    -   _Target_:  **Internet Gateway**  >  **IGW**
7.  Click  **Save routes**.
8.  Select  **PublicRT**, then click the  **Subnet Associations**  tab.
9.  Click  **Edit subnet associations**.
10.  Select our  **Public1**  subnet.
11.  Click  **Save**.

#### Create and Configure Private Route Table

1.  Click  **Create route table**, and set the following values:
    -   _Name tag_:  **PrivateRT**
    -   _VPC_:  **VPC1**
2.  Click  **Create**.
3.  Select  **PrivateRT**, then click the  **Subnet Associations**  tab.
4.  Click  **Edit subnet associations**.
5.  Select our  **Private1**  subnet.
6.  Click  **Save**.

### Create Two Network Access Control Lists (NACLs), and Associate Each with the Proper Subnet

#### Create and Configure Public NACL

1.  Click  **Network ACLs**  in the left-hand menu.
2.  Click  **Create network ACL**, and set the following values:
    -   _Name tag_:  **Public_NACL**
    -   _VPC_:  **VPC1**
3.  Click  **Create**.
4.  With  _Public_NACL_  selected, click the  **Inbound Rules**  tab below.
5.  Click  **Edit inbound rules**.
6.  Click  **Add Rule**, and set the following values:
    -   _Rule #_:  **100**
    -   _Type_:  **HTTP (80)**
    -   _Port Range_:  **80**
    -   _Source_:  **0.0.0.0/0**
    -   _Allow / Deny_:  **ALLOW**
7.  Click  **Add Rule**, and set the following values:
    -   _Rule #_:  **110**
    -   _Type_:  **SSH (22)**
    -   _Port Range_:  **22**
    -   _Source_:  **0.0.0.0/0**
    -   _Allow / Deny_:  **ALLOW**
8.  Click  **Save**.
9.  Click the  **Outbound Rules**  tab.
10.  Click  **Edit outbound rules**.
11.  Click  **Add Rule**, and set the following values:
    -   _Rule #_:  **100**
    -   _Type_:  **Custom TCP Rule**
    -   _Port Range_:  **1024-65535**
    -   _Destination_:  **0.0.0.0/0**
    -   _Allow / Deny_:  **ALLOW**
12.  Click  **Save**.
13.  Click the  **Subnet associations**  tab.
14.  Click  **Edit subnet associations**.
15.  Select the  **Public1**  subnet, and click  **Save changes**.

#### Create and Configure Private NACL

1.  Click  **Create network ACL**, and set the following values:
    -   _Name tag_:  **Private_NACL**
    -   _VPC_:  **VPC1**
2.  Click  **Create**.
3.  With  _Private_NACL_  selected, click the  **Inbound Rules**  tab below.
4.  Click  **Edit inbound rules**.
5.  Click  **Add Rule**, and set the following values:
    -   _Rule #_:  **100**
    -   _Type_:  **SSH (22)**
    -   _Port Range_:  **22**
    -   _Source_:  **172.16.1.0/24**
    -   _Allow / Deny_:  **ALLOW**
6.  Click  **Save**.
7.  Click the  **Outbound Rules**  tab.
8.  Click  **Edit outbound rules**.
9.  Click  **Add Rule**, and set the following values:
    -   _Rule #_:  **100**
    -   _Type_:  **Custom TCP Rule**
    -   _Port Range_:  **1024-65535**
    -   _Destination_:  **0.0.0.0/0**
    -   _Allow / Deny_:  **ALLOW**
10.  Click  **Save**.
11.  Click the  **Subnet associations**  tab.
12.  Click  **Edit subnet associations**.
13.  Select the  **Private1**  subnet, and click  **Save changes**.

## Conclusion

Congratulations on completing this hands-on lab!
